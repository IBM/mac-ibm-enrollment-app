//
//  TermDefinition.swift
//  enrollment
//
//  Created by Jay Latman on 7/26/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import Cocoa

/**
 Structure definition to create a term / definition paired listing for info popover views
 */
struct TermDefinition: Equatable {
    var term: String
    var definition: String
  
    static func ==(lhs: TermDefinition, rhs: TermDefinition) -> Bool {
        return lhs.term == rhs.term && lhs.definition == rhs.definition
    }
    
    /**
     Method for applying a `TermDefinition` to labels for info popover views
     
     - Parameter term : equatable `TermDefinition` comprised of two strings
     - Parameter leftLabel : NSTextField in the left position
     - Parameter rightLabel : NSTextField in the right position
    */
    static func assignTermDefinitionsToLabels(term: TermDefinition, leftLabel: NSTextField, rightLabel: NSTextField) {
        leftLabel.stringValue = term.term
        rightLabel.stringValue = term.definition
        leftLabel.textColor = .headerTextColor
        rightLabel.textColor = .headerTextColor
    }
}

/**
 Structure definition containing the string equivalents for state of settings used in SecurityDescriptionPopover
 */
struct State {
    let enabled = "Enabled"
    let disabled = "Disabled"
    let required = "Required"
}


