//
//  PrivilegedHelperController.swift
//  Mac@IBM
//
//  Created by Simone Martorelli on 8/24/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//
// swiftlint:disable line_length

import Cocoa
import ServiceManagement
import os.log

class PrivilegedHelperController: NSObject, NSXPCListenerDelegate {
    
    // MARK: - Static variables
    
    static let shared = PrivilegedHelperController()
    
    // MARK: - Private variables
    
    private var helperMachServiceName = "com.ibm.cio.be.PrivilegedCommandsHelper"
    private var xpcHelperConnection: NSXPCConnection?
    private var authRef: AuthorizationRef?
    
    // MARK: - Private methods
    
    private func prepareConnection() {
        guard self.xpcHelperConnection == nil else {
            os_log("XPC Connection ready")
            return
        }
        os_log("Preparing XPC Connection")
        self.xpcHelperConnection = NSXPCConnection(machServiceName: helperMachServiceName, options: [.privileged])
        self.xpcHelperConnection?.remoteObjectInterface = NSXPCInterface(with: RemoteProcessProtocol.self)
        self.xpcHelperConnection?.invalidationHandler = {
            self.xpcHelperConnection?.invalidationHandler = nil
            OperationQueue.main.addOperation {
                self.xpcHelperConnection = nil
                os_log("XPC Connection invalidated")
            }
        }
        self.xpcHelperConnection?.resume()
        os_log("Resuming XPC Connection")
    }
    
    private func helper(_ errorHandler: @escaping (Error) -> Void) -> RemoteProcessProtocol? {
        return self.xpcHelperConnection?.remoteObjectProxyWithErrorHandler({ (error) in
            errorHandler(error)
        }) as? RemoteProcessProtocol
    }
    
    private func initAuthorizationRef() {
        var authorizationExtForm = AuthorizationExternalForm()
        os_log("Requesting priviledged authorizations")
        var authStatus = AuthorizationCreate(nil, nil, AuthorizationFlags(), &authRef)
        guard authStatus == errAuthorizationSuccess, authRef != nil else {
            os_log(.error, "Authorization failure: %{public}@", authStatus.description)
            return
        }
        authStatus = AuthorizationMakeExternalForm(authRef!, &authorizationExtForm)
        guard authStatus == errAuthorizationSuccess else {
            os_log(.error, "Authorization failure: %{public}@", authStatus.description)
            return
        }
        guard authRef != nil else {
            os_log(.error, "Authorization failure: %{public}@", authStatus.description)
            return
        }
        let authName = kSMRightBlessPrivilegedHelper
        var blockErr = OSStatus()
        
        blockErr = AuthorizationRightGet(authName, nil)
        if blockErr == errAuthorizationDenied {
            blockErr = AuthorizationRightSet(authRef!,
                                             authName,
                                             kAuthorizationRuleAuthenticateAsAdmin as CFTypeRef,
                                             "Localizable" as CFString,
                                             nil,
                                             "Localizable" as CFString)
            guard blockErr == errAuthorizationSuccess else {
                os_log(.error, "Authorization failure: %{public}@", blockErr.description)
                return
            }
        }
        os_log("Authorization success: %{public}@", blockErr.description)
    }
    
    private func installHelperDaemon() {
        var error: Unmanaged<CFError>?
        var success: Bool = false
        
        success = SMJobBless(kSMDomainSystemLaunchd, helperMachServiceName as CFString, authRef, &error)
        
        if success {
            os_log("%{public}@ installed successfully", helperMachServiceName)
        } else {
            let blessError = error!.takeRetainedValue() as Error
            os_log(.error, "Bless Error: %{public}@", blessError.localizedDescription)
        }
    }
    
    private func checkIfHelperDaemonExists() -> Bool {
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: "/Library/PrivilegedHelperTools/\(helperMachServiceName)") {
            os_log("Helper not found")
            return false
        } else {
            os_log("Helper found")
            return true
        }
    }
    
    private func checkHelperVersionAndUpdateIfNecessary() {
        let helperURL = Bundle.main.bundleURL.appendingPathComponent("Contents/Library/LaunchServices/\(helperMachServiceName)")
        guard let helperBundleInfo = CFBundleCopyInfoDictionaryForURL(helperURL as CFURL),
              let helperVersion = (helperBundleInfo as NSDictionary)["CFBundleVersion"] as? String else {
            os_log(.error, "Failed to obtain Helper's new version value")
            return
        }
        
        os_log("PrivilegedCommandsHelper Bundle Version: %{public}@", helperVersion)
        os_log("Preparing XPC Service")
        self.prepareConnection()
        
        guard let xpcService = self.helper({ error in
            os_log(.error, "XPC Error: %{public}@", error.localizedDescription)
        }) else {
            os_log(.error, "XPC Service failed to obtain object's proxy")
            return
        }
        
        xpcService.getVersion(reply: { (installedVersion) in
            guard let installedVersion = installedVersion else {
                os_log(.error, "Failed to obtain Helper's installed version value")
                return
            }
            os_log("Helper Installed Version: %{public}@", installedVersion)
            if installedVersion != helperVersion {
                os_log("Starting installation of the latest version")
                self.installHelperDaemon()
            } else {
                os_log("Helper version is up to date!")
            }
        })
    }
    
    // MARK: - Public methods
    
    func setupHelperController() {
        initAuthorizationRef()
        if !checkIfHelperDaemonExists() {
            installHelperDaemon()
        } else {
            checkHelperVersionAndUpdateIfNecessary()
        }
    }
    
    func releaseAuthorizationRef() {
        AuthorizationFree(authRef!, AuthorizationFlags.destroyRights)
    }
    
    func processJAMFPolicy(_ policy: String) {
        #if !DEBUG
        self.prepareConnection()
        guard let xpcService = self.helper({ error in
            os_log(.error, "XPC Error: %{public}@", error.localizedDescription)
        }) else {
            os_log(.error, "XPC Service failed to obtain object's proxy")
            return
        }
        os_log("XPCService will run event: %{public}@", policy)
        xpcService.runPolicy(event: policy) { output in
            os_log("Jamf event execution completed with output: %@", output ?? "")
        }
        #else
        os_log(.debug, "User requested to run policy: %@", policy)
        #endif
    }
}
