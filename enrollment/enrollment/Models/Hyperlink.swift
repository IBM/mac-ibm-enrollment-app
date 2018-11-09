//
//  Hyperlink.swift
//  enrollment
//
//  Created by Jay Latman on 8/16/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Class definition for converting a NSTextField to accept mount input to open a url
 
 href : string value of a url to be appled to the textfield for openning in a web browser
 */
class Hyperlink: NSTextField {

    @IBInspectable var href: String = ""
    
    override func resetCursorRects() {
        discardCursorRects()
        addCursorRect(self.bounds, cursor: NSCursor.pointingHand)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        if let localHref = URL(string: href) {
            NSWorkspace.shared.open(localHref)
        }
    }
}
