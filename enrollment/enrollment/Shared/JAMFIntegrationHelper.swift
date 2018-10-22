//
//  JAMFIntegrationHelper.swift
//  com.ibm.enrollmentJAMFIntegrationHelper
//
//  Created by Jay Latman on 10/11/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import AppKit

class JAMFIntegrationHelper: NSObject, RemoteProcessProtocol, NSXPCListenerDelegate  {
    
    var listener: NSXPCListener
    
    override init() {
        self.listener = NSXPCListener(machServiceName:JAMFHelperConstants.machServiceName)
        super.init()
        self.listener.delegate = self
    }
    
    func run() {
        self.listener.resume()
        RunLoop.current.run()
    }
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: RemoteProcessProtocol.self)
        newConnection.exportedObject = self
        newConnection.resume()
        
        return true
    }
    
    func runPolicy(path: String, arguments: Array<String>, reply: @escaping ((NSNumber) -> Void)) -> Void {
        print("runPolicy \(arguments)")
        let jamfTask : Process = Process()
        
        jamfTask.launchPath = path
        jamfTask.arguments = arguments
        
        jamfTask.launch()
    }
    
    func getVersion(reply: @escaping (String) -> Void) {
        reply(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String)
    }
    
    func runCommand(event: String, reply: @escaping (NSNumber) -> Void) {
        let jamfLaunchPath = "/usr/local/jamf/bin/jamf"
        let jamfArguments = ["policy", "-event", event]
        
        NSLog("User: \(NSUserName())")
        NSLog("jamf command line: \(String(describing: jamfLaunchPath )) \(String(describing: jamfArguments.joined(separator: " ")))")
        
        runPolicy(path: jamfLaunchPath, arguments: jamfArguments, reply: reply)
    }
}
