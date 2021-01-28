//
//  NSButton+TextColor.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import AppKit

extension NSButton {
    
    /**
     Extension method for NSButton to change the text color and underline style. An example would be a button that mirrors an underlined URL link with no border.
     
     - Parameter color : NSColor for the attributed to the button title
     - Parameter underlineStyle : NSUnderlineStyle
    */
    func set(textColor color: NSColor, underline underlineStyle: NSUnderlineStyle.RawValue) {
        let newAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        let range = NSRange(location: 0, length: attributedTitle.length)
        
        newAttributedTitle.addAttributes([
            .underlineStyle: underlineStyle,
            .foregroundColor: color
            ], range: range)
        
        attributedTitle = newAttributedTitle
    }
    
    /**
     Extension method for applying an underline style to a NSButton. The color is hardcoded in the method.
     
     - Parameter toggleLabel : string value to be applied to the title attribute
     - Parameter underline : integer value for NSUnderlineStyle
    */
    func set(toggleLabel: String, underline: Int) {
        self.title = toggleLabel
        self.set(textColor: NSColor.headerTextColor, underline: NSUnderlineStyle.init(rawValue: underline).rawValue)
    }
}
