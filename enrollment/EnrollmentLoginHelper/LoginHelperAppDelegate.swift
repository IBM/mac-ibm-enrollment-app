//
//  LoginHelperAppDelegate.swift
//  EnrollmentLoginHelper
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

@NSApplicationMain
class LoginHelperAppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let runningApps = NSWorkspace.shared.runningApplications
        
        let isRunning = runningApps.contains {
            $0.bundleIdentifier == "com.ibm.enrollment"
        }
        
        if !isRunning {
            print(isRunning)
            var path = Bundle.main.bundlePath as NSString
            for _ in 1...4 {
                path = path.deletingLastPathComponent as NSString
            }
            NSWorkspace.shared.launchApplication(path as String)
        }
    }
}
