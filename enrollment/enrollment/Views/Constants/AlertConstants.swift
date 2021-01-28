//
//  AlertConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/30/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

struct AlertText {
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert sheet to user upon cancelling / opting out of enrollment.
     
     • header : header message string
     
     • message : body message string
     */
    struct RegistrationCancelAlert {
        static let header: String = "unenrollmentAlertTitle".localized
        static let message: String = "unenrollmentAlertMessage".localized
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert sheet to user when attempting to install bundles where the estimated download time exceeds the `estimatedDownloadTimeInSecondsThreshold`.
     
     • header : header message string
     
     • message : body message string
     */
    struct BundleSelectionWarning {
        static let header: String = "bundleSelectionAlertTitle".localized
        static let message: String = "bundleSelectionAlertMessage".localized
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String value used for displaying alert string to user if any bundle app installations experienced failures.
     
     •  message : string value to be displayed below the header string of the bundle installation view
     */
    struct BundleInstallationWarning {
        static let message: String = "bundleInstallationalertMessage".localized
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert window to user in the event that the application is launched and can not locate the jamf binary.
     
     •  header : header message string
     
     •  message : body message string
     */
    struct FailureToLaunch {
        static let header: String = "launchFailureAlertTitle".localized
        static let message: String = "launchFailureAlertMessage".localized
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert sheet to user if the internal or external network is not available.
     
     child structs:
     
     External, Internal
     */
    struct NetworkValidationMessaging {
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values.
         - Note: string values used for displaying alert sheet to user should the public network not be reachable or the JPS is not available.
         
         •  network : network alert string
         
         •  jps : jps unreachable alert string
         */
        struct External {
            static let network: String = "externalNetworkAlertMessage".localized
            static let jps: String = "externalNetworkJspMessage".localized
        }
        
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values.
         
         String values used for displaying alert sheet to user should the intranet not be reachable.
         
         •  url : string value of an internal URL for validation
         
         •  warning : message displayed to the user
         */
        struct Internal {
            static let url = "https://w3.ibm.com/"
            static let warning = "internalNetworkProblemAlertMessage".localized
        }
    }
}
