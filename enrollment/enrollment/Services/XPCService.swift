//
//  XPCService.swift
//  enrollment
//
//  Created by Jay Latman on 10/12/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa
import ServiceManagement

class XPCService: NSObject, NSXPCListenerDelegate {
    
    private var xpcHelperConnection: NSXPCConnection?
    
    private var authRef: AuthorizationRef?
    private var connection: NSXPCConnection?
    private var listener: NSXPCListener?
    
    static let sharedInstance: XPCService = {
        let instance = XPCService()
        return instance
    }()
    
    private override init() {
        self.listener = NSXPCListener(machServiceName: JAMFHelperConstants.machServiceName)
        super.init()
        self.listener?.delegate = self
    }
    
    private func prepareXPC() -> NSXPCConnection? {
        if (connection == nil) {
            connection = NSXPCConnection(machServiceName: JAMFHelperConstants.machServiceName, options: NSXPCConnection.Options.privileged)
            connection?.remoteObjectInterface = NSXPCInterface(with: RemoteProcessProtocol.self)
            connection?.invalidationHandler = {
                OperationQueue.main.addOperation {
                    self.connection = nil
                    NSLog("Enrollment: XPC Connection Invalidated")
                }
            }
            connection?.resume()
        }
        
        return connection
    }
    
    private func helper(_ completion: ((Bool) -> Void)?) -> RemoteProcessProtocol? {
        guard let helper = self.xpcHelperConnection?.remoteObjectProxyWithErrorHandler({ (error) in
            NSLog("Error : \(error)")
            if let onCompletion = completion { onCompletion(false) }
        }) as? RemoteProcessProtocol else { return nil }
        return helper
    }
    
    func initAuthorizationRef() {
        let status = AuthorizationCreate(nil, nil, AuthorizationFlags(), &authRef)
        if (status != OSStatus(errAuthorizationSuccess)) {
            NSLog("Enrollment JAMFIntegrationHelper: Authorization failure")
            return
        }
    }
    
    func releaseAuthorizationRef() {
        AuthorizationFree(authRef!, AuthorizationFlags.destroyRights)
    }
    
    func installHelperDaemon() {
        NSLog("Enrollment: Privileged Helper daemon not found, installing a new one......")
        
        var authRef: AuthorizationRef?
        var authStatus = AuthorizationCreate(nil, nil, [], &authRef)
        
        guard authStatus == errAuthorizationSuccess else {
            NSLog("Enrollment: Authorization failure: \(authStatus)")
            return
        }
        
        var authItem = AuthorizationItem(name: kSMRightBlessPrivilegedHelper, valueLength: 0, value: nil, flags: 0)
        var authRights = AuthorizationRights(count: 1, items: &authItem)
        let flags: AuthorizationFlags = [[], .interactionAllowed, .extendRights, .preAuthorize]
        authStatus = AuthorizationCreate(&authRights, nil, flags, &authRef)
        
        guard authStatus == errAuthorizationSuccess else {
            NSLog("Enrollment: could not obtain admin privileges: \(authStatus)")
            return
        }
        
        var error: Unmanaged<CFError>? = nil
        
        if (SMJobBless(kSMDomainSystemLaunchd, JAMFHelperConstants.machServiceName as CFString, authRef, &error) == false) {
            let blessError = error!.takeRetainedValue() as Error
            NSLog("Enrollment: Bless Error: \(blessError)")
        } else {
            NSLog("Enrollment: \(JAMFHelperConstants.machServiceName) installed successfully")
        }
        
        AuthorizationFree(authRef!, [])
    }
    
    // Check if JAMF Integration Helper daemon exists
    func checkIfHelperDaemonExists() -> Bool {
        let fileManager = FileManager.default
        
        if (!fileManager.fileExists(atPath: "/Library/PrivilegedHelperTools/\(JAMFHelperConstants.machServiceName)")) {
            return false
        } else {
            return true
        }
    }
    
    // Compare app's helper binary version to installed daemon's version and update if not equal
    func checkHelperVersionAndUpdateIfNecessary() {
        let helperURL = Bundle.main.bundleURL.appendingPathComponent("Contents/Library/LaunchServices/\(JAMFHelperConstants.machServiceName)")
        let helperBundleInfo = CFBundleCopyInfoDictionaryForURL(helperURL as CFURL)
        let helperInfo = helperBundleInfo! as NSDictionary
        let helperVersion = helperInfo["CFBundleVersion"] as! String
        
        NSLog("Enrollment: JAMFIntegrationHelper Bundle Version => \(helperVersion)")
        
        let xpcService = prepareXPC()?.remoteObjectProxyWithErrorHandler() { error -> Void in
            NSLog("XPC error: \(error)")
            } as? RemoteProcessProtocol
        
        xpcService?.getVersion(reply: { (installedVersion) in
            NSLog("Enrollment: JAMFIntegrationHelper Installed Version => \(installedVersion)")
            if (installedVersion != helperVersion) {
                self.installHelperDaemon()
            } else {
                NSLog("Enrollment: Bundle version matches privileged helper version")
            }
        })
    }
    
    func helperConnection() -> NSXPCConnection? {
        guard self.xpcHelperConnection == nil else {
            return self.xpcHelperConnection
        }
        let connection = NSXPCConnection(machServiceName: JAMFHelperConstants.machServiceName, options:[.privileged])
        connection.exportedObject = self
        connection.remoteObjectInterface = NSXPCInterface(with: RemoteProcessProtocol.self)
        connection.invalidationHandler = {
            self.xpcHelperConnection?.invalidationHandler = nil
            OperationQueue.main.addOperation {
                self.xpcHelperConnection = nil
            }
        }
        
        self.xpcHelperConnection = connection
        self.xpcHelperConnection?.resume()
        return self.xpcHelperConnection
    }
    
    func processJAMFAction(event: String) {
        let xpcConnection = prepareXPC()?.remoteObjectProxyWithErrorHandler() { error -> Void in
            print("XPCService error: ", error) } as? RemoteProcessProtocol
        
        xpcConnection?.runCommand(event: event, reply: { (exitCode) in
            print(exitCode)
            }
        )
    }
}
