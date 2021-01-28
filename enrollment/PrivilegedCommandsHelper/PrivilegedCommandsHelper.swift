//
//  PrivilegedCommandsHelper.swift
//  PrivilegedCommandsHelper
//
//  Created by Simone Martorelli on 8/24/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import AppKit
import os.log

class PrivilegedCommandsHelper: NSObject, NSXPCListenerDelegate {

    var listener: NSXPCListener

    override init() {
        self.listener = NSXPCListener(machServiceName: "com.ibm.cio.be.PrivilegedCommandsHelper")
        super.init()
        self.listener.delegate = self
    }

    func run() {
        self.listener.resume()
        RunLoop.current.run()
        os_log("PrivilegedCommandsHelper running")
    }

    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: RemoteProcessProtocol.self)
        newConnection.exportedObject = self
        newConnection.resume()
        return true
    }
}

extension PrivilegedCommandsHelper: RemoteProcessProtocol {
    func getVersion(reply: @escaping (String?) -> Void) {
        os_log("PrivilegedCommandsHelper received \"getVersion\" request")
        reply(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String)
    }

    private func runCommand(path: String?, arguments: [String], reply: @escaping (String?) -> Void) {
        os_log("PrivilegedCommandsHelper received \"runCommand\" request with path: %@ and argments: %@", path ?? "No path", arguments.description)
        let process = Process()
        process.launchPath = path
        process.arguments = arguments
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
        process.waitUntilExit()
        reply(String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8))
    }

    func runPolicy(event: String, reply: @escaping (String?) -> Void) {
        let jamfLaunchPath = "/usr/local/jamf/bin/jamf"
        let jamfArguments = ["policy", "-event", event]
        runCommand(path: jamfLaunchPath, arguments: jamfArguments, reply: reply)
    }
}
