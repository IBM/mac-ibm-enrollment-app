//
//  NSButton+TextColor.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//


import AppKit

extension NSButton {
    func set(textColor color: NSColor, underline underlineStyle: NSUnderlineStyle.RawValue) {
        let newAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        let range = NSRange(location: 0, length: attributedTitle.length)
        
        newAttributedTitle.addAttributes([
            .underlineStyle: underlineStyle,
            .foregroundColor: color
            ], range: range)
        
        attributedTitle = newAttributedTitle
    }
    
    func set(toggleLabel: String, underline: Int) {
        self.title = toggleLabel
        self.set(textColor: NSColor.headerTextColor, underline: NSUnderlineStyle.init(rawValue: underline).rawValue)
    }
}
