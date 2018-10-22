//
//  Hyperlink.swift
//  enrollment
//
//  Created by Jay Latman on 8/16/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

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
