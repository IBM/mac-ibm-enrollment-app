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
    let context = Context.main
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Validate if the jamf binary is present, if so initate an authorization reference
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            PrivilegedHelperController.shared.setupHelperController()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Validate if the jamf binary is present, if so release the authorization reference
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == true {
            PrivilegedHelperController.shared.releaseAuthorizationRef()
        }
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                  let path = components.path, path == "updateuistatus",
                  let params = components.queryItems else {
                return
            }
            for param in params {
                guard let value = param.value else { continue }
                guard let statusRawValue = Int(value),
                      let newStatus = EnrollmentBundle.InstallationStatus.init(rawValue: statusRawValue) else {
                    Context.main?.receivedNewMessage(for: param.name, newMessage: value.replacingOccurrences(of: "_", with: " "))
                    return
                }
                Context.main?.receivedNewStatus(for: param.name, newStatus: newStatus)
            }
        }
    }
}
