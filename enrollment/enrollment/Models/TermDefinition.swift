//
//  TermDefinition.swift
//  enrollment
//
//  Created by Jay Latman on 7/26/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import Cocoa

struct TermDefinition: Equatable {
    var term: String
    var definition: String
  
    static func ==(lhs: TermDefinition, rhs: TermDefinition) -> Bool {
        return lhs.term == rhs.term && lhs.definition == rhs.definition
    }
    static func assignTermDefinitionsToLabels(term: TermDefinition, leftLabel: NSTextField, rightLabel: NSTextField) {
        leftLabel.stringValue = term.term
        rightLabel.stringValue = term.definition
        leftLabel.textColor = .headerTextColor
        rightLabel.textColor = .headerTextColor
    }
}

struct State {
    let enabled = "Enabled"
    let disabled = "Disabled"
    let required = "Required"
}


