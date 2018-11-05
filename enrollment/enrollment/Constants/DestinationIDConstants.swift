//
//  DestinationIDConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

/**
 Structure definition containing reference to Storyboard Segue Identifiers found in interface builder and used throughout the navigation.
 
 child structs:
 
 ReturnTo, ForwardTo, SkipTo, Popover
 */
struct SegueDestinationID {
    struct ReturnTo {
        static let primaryRegistrationChildViewController = "ReturnToPrimaryRegistrationChildViewControllerSegue"
        static let setupCompleteChildViewControllerSegue = "ReturnToSetupCompleteChildViewControllerSegue"
    }
    
    struct ForwardTo {
        static let secondaryRegistrationChildViewController = "ForwardToSecondaryRegistrationChildViewControllerSegue"
        static let progressRegistrationChildViewController = "ForwardToProgressChildViewControllerSegue"
        static let registrationCompleteChildViewControllter = "ForwardToRegistrationCompleteChildViewControllerSegue"
        static let bundleInstallationChildViewController = "ForwardToBundleInstallationChildViewControllerSegue"
        static let setupCompleteChildViewController = "ForwardToSetupCompleteChildViewControllerSegue"
    }
  
    struct SkipTo {
        static let setupCompleteChildViewConroller = "SkipToSetupCompleteChildViewControllerSegue"
    }
    
    struct Popover {
        struct PrimaryRegisrationChildViewController {
            static let securityDescription = "PopoverSegueSecurityDescription"
            static let info4 = "PopoverSegueInfo4"
            static let info2 = "PopoverSegueInfo2"
        }
        struct SecondaryRegistrationChildViewController {
            static let optionDescriptions = "PopoverSegueOptionDescription"
        }
        struct BundleSelectionChildViewController {
            static let essentials = "PopoverSegueEssentialsBundle"
            static let productivity = "PopoverSegueProductivityBundle"
        }
    }
}

/**
 Structure definition containing reference to Storyboard Identifiers used for key phases referenced in `SubViewControllerManagerViewController` .
 
 • primaryRegistrationChildViewController : First registration view displayed on first launch
 
 • bundleSelectionChildViewController : View displayed after restart allowing users to select and install software
 
 • setupCompleteChildViewController : Final view that the user can choose to return to well after the first run
 
 child structs:
 
 Keys
 */
struct StartingPointID {
    static let setupCompleteChildViewController = "SetupCompleteChildViewController"
    static let bundleSelectionChildViewController = "BundleSelectionChildViewController"
    static let primaryRegistrationChildViewController = "PrimaryRegistrationChildViewController"
    
    /**
     • `phase` : [Key] String interpreted integer corresponding to phase of enrollment
     #  0 = Registration
     #  1 = Bundle Installation
     #  2 = Setup Complete
     */
    struct Keys {
        static let phase = "phase"
    }
}
