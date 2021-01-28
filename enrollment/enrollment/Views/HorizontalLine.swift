//
//  HorizontalLine.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class provide a simple horizontal line.
class HorizontalLine: NSView {
    override func draw(_ dirtyRect: NSRect) {
        NSColor.darkGray.set()
        NSRect(x: 0, y: 0, width: dirtyRect.width, height: 1).fill()
    }
}
