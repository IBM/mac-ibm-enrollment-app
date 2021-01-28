//
//  LabelButton.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import AppKit

class LabelButton: NSControl {
    var backgroundColor: NSColor = NSColor.clear {
        didSet {
            self.needsDisplay = true
        }
    }
    var title: String = ""
    var titleLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        titleLabel?.removeFromSuperview()
        titleLabel = NSTextField(wrappingLabelWithString: title)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.textColor = NSColor.linkColor
    }

    override func mouseDown(with event: NSEvent) {
        self.titleLabel.textColor = NSColor.selectedControlColor
    }

    override func mouseUp(with event: NSEvent) {
        self.titleLabel.textColor = NSColor.linkColor
        guard let action = action else {return}
        tryToPerform(action, with: self)
    }

    override func resetCursorRects() {
        super.resetCursorRects()
        DispatchQueue.main.async {
            self.addCursorRect(self.bounds, cursor: .pointingHand)
        }
    }
}
