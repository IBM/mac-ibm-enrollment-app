//
//  BundleInstallationChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct BundleInstallationChildVC_Constants {
    static let header = "Installing selected app bundles…"
    static let estimatedTimeRemainingMessageTextLabel = "Estimated time remaining :"
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     The following references map to string values to be applied to buttons per bundle header instance displayed on the bundle installation view.
     
     • open : string value for when a button is on
     
     • closed : string value for when a button is off
     */
    struct DisclosureButtonLabelText {
        static let open = "Hide Apps"
        static let closed = "Show Apps"
    }
}
