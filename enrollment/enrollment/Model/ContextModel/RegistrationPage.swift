//
//  RegistrationPage.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class RegistrationPage: Codable, Equatable {
    var title: InfoLabel
    var subtitle: InfoLabel?
    var fields: [RegistrationField]
    var footer: InfoLabel?
    
    init(_ title: InfoLabel, subtitle: InfoLabel? = nil, fields: [RegistrationField], footer: InfoLabel? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.fields = fields
        self.footer = footer
    }
    
    public static func == (lhs: RegistrationPage, rhs: RegistrationPage) -> Bool {
        return lhs.fields == rhs.fields && lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.footer == rhs.footer
    }
}
