//
//  EnrollmentWindowController.swift
//  enrollment
//
//  Created by Jay Latman on 7/23/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// The main window controller for the application.
class EnrollmentWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.isMovableByWindowBackground = true
        window?.level = .normal
        window?.setAccessibilityIdentifier("Mac@IBM Enrollment")
        window?.titleVisibility = .visible
    }
}
