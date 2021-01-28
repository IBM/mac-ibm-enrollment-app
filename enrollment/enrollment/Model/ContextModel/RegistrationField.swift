//
//  RegistrationField.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class RegistrationField: Codable, Equatable {
    public struct Option: Codable {
        var key: String
        var label: String
        var isExclusive: Bool?
    }
    
    var title: InfoLabel
    var key: String
    var multipleChoiseAllowed: Bool
    var showTitle: Bool?
    var options: [Option]
    
    var optionKeys: [String] {
        var array: [String] = []
        for option in options {
            array.append(option.key)
        }
        return array
    }
    
    var optionLabels: [String] {
        var array: [String] = []
        for option in options {
            array.append(option.label)
        }
        return array
    }
    
    init(_ title: InfoLabel, key: String, options: [Option], multipleChoiseAllowed: Bool, showTitle: Bool? = nil) {
        self.title = title
        self.key = key
        self.options = options
        self.multipleChoiseAllowed = multipleChoiseAllowed
        self.showTitle = showTitle
    }
    
    public static func == (lhs: RegistrationField, rhs: RegistrationField) -> Bool {
        return lhs.key == rhs.key
    }
}
