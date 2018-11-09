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
    /**
     Method for handling the UI controls for the Bundle Selection view
     
     - Parameter label : NSTextField for the `totalDownloadTime`
     - Parameter labelState : Boolean value for whether the label should be displayed
     - Parameter installButton : NSButton for advancing to the installation screen
     - Parameter installButtonState : Boolean value for whether the `installButton` should be displayed
     - Parameter skipButton : NSButton for advancing to the SetupComplete / education view
     - Parameter skipButtonState : Boolean value for whether the `skipButton` should be displayed
     */
    static func displayButtons(label: NSTextField, labelState: Bool, installButton: NSButton, installButtonState: Bool, skipButton: NSButton, skipButtonState: Bool) {
        
        label.isHidden = labelState
        installButton.isHidden = installButtonState
        skipButton.isHidden = skipButtonState
    }
}
