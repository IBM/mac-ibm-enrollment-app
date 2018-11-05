//
//  SetupCompleteChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Structure definition for the setup complete / education view
 
 • header : string value for the text label at the top of the view
 
 • showOnRestartToggleLabel : string value for the text applied adjacent to the check box toggle used for adding or removing the login helper
 
 • helperBundleIdentifier : string value for the bundle id associated with the login helper
 
 child structs : LinkOuts
 */
struct SetupCompleteChildVC_Constants {
    static let header = "Get started with your Mac"
    static let showOnRestartToggleLabel = " Remind me the next time I restart my Mac."
    static let helperBundleIdentifier = "com.ibm.EnrollmentLoginHelper"
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     
     LinkOuts are of the URL tied connection entries to be displayed in the scroll view. Each entry is paired based on index value per array.
     
     • icons : Array of images. These could be code driven or referenced from the asset catalog
     
     • headerLabels : Array of header strings used in conjuction with a url to create a link
     
     • urls : Array of URLs
     
     • descriptionLabels : Array of strings providing descriptions for each linkout
     */
    struct LinkOuts {
        static let icons: [NSImage] = [
            SetupCompleteButtons.imageOfSelfServiceButton,
            SetupCompleteButtons.imageOfMigrationButton,
            SetupCompleteButtons.imageOfBackupButton,
            SetupCompleteButtons.imageOfQnAButton
        ]
        
        static let headerLabels: [String] = [
            WebLinkButtons.SelfService.header,
            WebLinkButtons.Migration.header,
            WebLinkButtons.Backup.header,
            WebLinkButtons.Help.header
        ]
        
        static let urls: [String] = [
            WebLinkButtons.SelfService.url,
            WebLinkButtons.Migration.url,
            WebLinkButtons.Backup.url,
            WebLinkButtons.Help.url
        ]
        
        static let descriptionLabels: [String] = [
            WebLinkButtons.SelfService.description,
            WebLinkButtons.Migration.description,
            WebLinkButtons.Backup.description,
            WebLinkButtons.Help.description
        ]
    }
}

