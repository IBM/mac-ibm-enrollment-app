//
//  NSTextField+Attributes.swift
//  enrollment
//
//  Created by Jay Latman on 8/9/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import Cocoa

extension NSTextField {
    
    /**
     Extension method for applying a color and string to a NSTextField
     
     - Parameter label : string value to be applied to textfield
     - Parameter color : NSColor to be applied to textfield
    */
    func set(label: String, color: NSColor) {
        self.stringValue = label
        self.textColor = color
    }
}

