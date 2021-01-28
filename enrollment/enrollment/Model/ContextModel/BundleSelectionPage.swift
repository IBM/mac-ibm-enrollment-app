//
//  BundleSelectionPage.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class BundleSelectionPage: Codable {
    var title: InfoLabel
    var subtitle: InfoLabel?
    var bundles: [EnrollmentBundle]
    
    init(_ title: InfoLabel, subtitle: InfoLabel? = nil, bundles: [EnrollmentBundle]) {
        self.title = title
        self.subtitle = subtitle
        self.bundles = bundles
    }
}
