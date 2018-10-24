//
//  BundleInstallButtonVisibility.swift
//  enrollment
//
//  Created by Jay Latman on 8/8/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import Cocoa

struct BundleInstallButtonVisibility {
    static func displayButtons(label: NSTextField, labelState: Bool, installButton: NSButton, installButtonState: Bool, skipButton: NSButton, skipButtonState: Bool) {
        
        label.isHidden = labelState
        installButton.isHidden = installButtonState
        skipButton.isHidden = skipButtonState
    }
}
