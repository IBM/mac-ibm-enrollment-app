//
//  AlertConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/30/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Structure definition containing reference assignments of stored values for alert messaging.
 
 child structs:
 
 RegistrationCancelAlert, BundleSelectionWarning, BundleInstallationWarning, FailureToLaunch, NetworkWarnings, RegistrationComplete
 */
struct AlertText {
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert sheet to user upon cancelling / opting out of enrollment.
     
     • header : header message string
     
     • message : body message string
     */
    struct RegistrationCancelAlert{
        static let header: String = "Are you sure you want to quit the enrollment process?"
        static let message: String = "Cancelling now will undo all security settings and remove this computer from the management."
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert sheet to user when attempting to install bundles where the estimated download time exceeds the `estimatedDownloadTimeInSecondsThreshold`.
     
     • header : header message string
     
     • message : body message string
     */
    struct BundleSelectionWarning {
        static let header: String = "Are you sure you want to proceed?"
        static let message: String = "It looks like your network speeds are slow at this time. We recommend installing fewer bundles."
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String value used for displaying alert string to user if any bundle app installations experienced failures.
     
     • message : string value to be displayed below the header string of the bundle installation view
     */
    struct BundleInstallationWarning {
        static let message: String = "We had trouble installing some applications - use Self Service to install them later."
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     String values used for displaying alert window to user in the event that the application is launched and can not locate the jamf binary.
     
     • header : header message string
     
     • message : body message string
     */
    struct FailureToLaunch {
        static let header: String = "This application requires device management."
        static let message: String = "Please enroll this device."
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
         
         String values used for displaying alert sheet to user should the public network not be reachable or the JPS is not available.
         • `network`: network alert string
         
         • `jps`: jps unreachable alert string
         */
        struct External {
            static let network: String = "You are not connected to the Internet.  Please make sure that your Mac is connected to a network with Internet access before continuing."
            static let jps: String = "Self Service is not available at this time.  Please try again later."
        }
        
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values.
         
         String values used for displaying alert sheet to user should the intranet not be reachable.
         
         • url : string value of an internal URL for validation
         
         • warning : message displayed to the user
         */
        struct Internal {
            static let url = ""
            static let warning = """
                                
                                You must connect to the intranet to proceed.
                                """
        }
    }
}

/**
 Structure definition containing reference assignments of stored values or property list key names for retrieving values.
 
 Time in seconds limit for retaining `BundleInstallationWarning`.
 
 • estimatedDownloadTimeInSecondsThreshold : Double
 */
struct CalculationThresholds {
    static let estimatedDownloadTimeInSecondsThreshold = 3000.0
}


/**
 Structure definition containing reference assignments of stored values or property list key names for retrieving values.
 
 String values used for user interaction button labels.
 
 • yes
 
 • no
 
 • quit
 
 Child structs:
 InteractionLogText
 */
struct UserInteractionButtons {
    static let yes = "Yes"
    static let no = "No"
    static let quit = "Quit"
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     */
    struct InteractionLogText {
        static let removeFrameworkCancelledLog = "Remove Framework action cancelled"
    }
}
