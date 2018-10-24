//
//  JAMFConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct JPSPaths {
    static let binaryPath = "/usr/local/jamf/bin/jamf"
    
    struct HealthCheckURLs {
        struct Eng {
            static let healthCheckURL = ""
        }
        struct QA {
            static let healthCheckURL = ""
        }
        struct Prod {
            static let healthCheckURL = ""
        }
    }
}

struct JAMFPolicyEventID {
    static let softwareInstall = ""
    static let removeFramework = ""
}
