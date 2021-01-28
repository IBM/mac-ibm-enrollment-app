//
//  RegistrationData.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

/// This object contains the information needed to present the registration phase to the end user.
public final class RegistrationData: Codable {
    /// Array of the registration page that should be exposed to the user in the registration phase.
    var pages: [RegistrationPage]
    /// True if the registration process has been completed, false if not. (Default: false).
    var registrationStatus: Bool? {
        didSet {
            UserDefaults.standard.set(registrationStatus, forKey: UserDefaultHelper.Keys.registrationStatus)
        }
    }
    
    init(_ pages: [RegistrationPage],
         registrationStatus: Bool? = nil) {
        self.pages = pages
        self.registrationStatus = registrationStatus
    }
}
