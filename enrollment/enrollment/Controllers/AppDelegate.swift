//
//  AppDelegate.swift
//  enrollment
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        /// Validate if the jamf binary is present, if so initiate an authorization reference
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            XPCService.sharedInstance.initAuthorizationRef()
            
            /// If the helper is not found, prompt the customer to install the helper from the app bundle else validate the version and update the helper if needed
            if (!XPCService.sharedInstance.checkIfHelperDaemonExists()) {
                XPCService.sharedInstance.installHelperDaemon()
            } else {
                XPCService.sharedInstance.checkHelperVersionAndUpdateIfNecessary()
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
        /// Validate if the jamf binary is present, if so release the authorization reference
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            XPCService.sharedInstance.releaseAuthorizationRef()
        }
    }
}

