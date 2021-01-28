//
//  Policies.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class JamfPoliciesStore: Codable {
    var registrationPolicy: String
    var bundleInstallationPolicy: String
    var removeFramework: String
    
    init(_ registrationPolicy: String,
         bundleInstallationPolicy: String,
         removeFramework: String) {
        self.registrationPolicy = registrationPolicy
        self.bundleInstallationPolicy = bundleInstallationPolicy
        self.removeFramework = removeFramework
    }
}
