//
//  AppDelegate.swift
//  enrollment
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            XPCService.sharedInstance.initAuthorizationRef()
            
            if (!XPCService.sharedInstance.checkIfHelperDaemonExists()) {
                XPCService.sharedInstance.installHelperDaemon()
            } else {
                XPCService.sharedInstance.checkHelperVersionAndUpdateIfNecessary()
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            XPCService.sharedInstance.releaseAuthorizationRef()
        }
    }
}

