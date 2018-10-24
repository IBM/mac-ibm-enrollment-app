//
//  BundleSelectionChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct BundleSelectionChildVC_Constants {
    static let header = "App bundles to get you started"
    static let subheader = "Additional apps can be installed from Self Service at any time."
    static let recommend_label = "(recommended)"
    
    struct Keys {
        static let environment = "environment"
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     - Note: Child structs:
     
     Title, Description
     */
    struct Toggle {
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values.
         - Note: The following references map to string values to be applied to each checkbox toggle button title
         
         • `a`: first checkbox button title
         
         • `b`: second checkbox button title
         
         • `c`: third checkbox button title
         */
        struct Title {
            static let a = "Connectivity"
            static let b = "Essentials"
            static let c = "Productivity"
        }
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values.
         - Note: The following references map to string values to be applied below each checkbox toggle button title
         
         • `a`: first checkbox description
         
         • `b`: second checkbox description
         
         • `c`: third checkbox description
         */
        struct Description {
            static let a = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            static let b = ""
            static let c = ""
        }
    }
}
