//
//  RegistrationChoice.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/8/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class RegistrationChoice: Codable, Hashable {
    var fieldKey: String
    var fieldTitle: String
    var selectedOptionKeys: [String]
    var selectedOptionTitles: [String]
    var isMultipleChoiseAllowed: Bool
    
    init(_ fieldKey: String, fieldTitle: String, selectedOptionKeys: [String], selectedOptionTitles: [String], isMultipleChoiseAllowed: Bool = false) {
        self.fieldKey = fieldKey
        self.fieldTitle = fieldTitle
        self.selectedOptionKeys = selectedOptionKeys
        self.selectedOptionTitles = selectedOptionTitles
        self.isMultipleChoiseAllowed = isMultipleChoiseAllowed
    }
    
    public static func == (lhs: RegistrationChoice, rhs: RegistrationChoice) -> Bool {
        return lhs.fieldKey == rhs.fieldKey
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(fieldKey)
    }
}
