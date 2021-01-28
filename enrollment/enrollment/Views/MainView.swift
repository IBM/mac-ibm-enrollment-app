//
//  MainView.swift
//  Mac@IBM Enrollment
//
//  Created by Jay Latman on 12/11/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// Through view hierarchy, this class uses the asset catalog color swatch to condition the background color for dark and light mode adoption
class MainView: NSView {
    override func updateLayer() {
        layer?.backgroundColor = backgroundColor?.cgColor
    }
    
    var backgroundColor = NSColor(named: ColorConstants.BackgroundColor.standard) {
        didSet {
            needsDisplay = true
        }
    }
}
