//
//  JAMFConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

/**
 Structure containing stored property strings pertaining to paths used by the jamf binary process
 
 • binaryPath : path location for the jamf binary
 
 child structs:
 
 HealthCheckURLs
 */
struct JPSPaths {
    static let binaryPath = "/usr/local/jamf/bin/jamf"
    
    /**
     Structure containing the stored property strings for the health check URL's used for testing network reachability to the Jamf infrastructure. Setting the environment in the application's user level property list allows you to override the healthCheck URL for testing. If your organization only has one environment, fill in the healthCheckURL for the Prod struct.
    */
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

/**
 Structure containing the Jamf event policy trigger strings for execution.
 
 The enrollment app uses Jamf policy events issued through the XPC communication to the Jamf Integration Helper to perform actions against the jamf binary.
 
 - softwareInstall : policy event trigger string that is used on load of the `BundleInstallationChildViewController` to start the process of bundle installation. The script attributed to this policy would analyze the selections made by the customer and stored in the application's user level property list, running the policy chain to install software and update the progress using the same user level property list.
 
 - removeFramework : to comply with GDPR, we offer the option for customers to opt out of the service. This policy event trigger string is used at the `PrimaryRegistrationChildViewController` to execute a policy which would remove the framework and any other components we have installed.
 */
struct JAMFPolicyEventID {
    static let softwareInstall = ""
    static let removeFramework = ""
}
