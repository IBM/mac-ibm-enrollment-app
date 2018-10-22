//
//  InfoPopOverConstants.swift
//  enrollment
//
//  Created by Jay Latman on 7/26/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

struct InfoPopoverConstants {
    struct PrimaryRegistrationVC {
        
        /**
         String value attributed to the info popover on the `PrimaryRegistrationChildViewController` detailing what to do if the username is incorrect
         */
        static let incorrectUserMessage = ""
        
        
        /**
         Term / Definition combinations to be displayed in the Security Descriptions Popover
         
         Notes:
         
         `SegueID : PopoverSegueSecurityDescription`
         */
        struct SecuritySettings {
            static let object1 = TermDefinition(term: "Firewall", definition: State.init().enabled)
            static let object2 = TermDefinition(term: "Stealth Mode", definition: State.init().enabled)
            static let object3 = TermDefinition(term: "Guest User Account", definition: State.init().disabled)
            static let object4 = TermDefinition(term: "FileVault Disk Encryption", definition: State.init().enabled)
            static let object5 = TermDefinition(term: "Initial macOS Password Change", definition: State.init().required)
            static let object6 = TermDefinition(term: "ScreenSaver Password", definition: State.init().required)
            static let object7 = TermDefinition(term: "ScreenSaver Start Time", definition: "30 minutes of inactivity")
        }
        
        /**
         Term / Definition combinations to be displayed for PopupButton 2 Info
         
         Notes:
         
         `SegueID : PopoverSegueInfo2`
         */
        struct Info2 {
            static let object1 = TermDefinition(term: "Type 1", definition: "")
            static let object2 = TermDefinition(term: "Type 2", definition: "")
            static let object3 = TermDefinition(term: "Type 3", definition: "")
            static let object4 = TermDefinition(term: "Type 4", definition: "")
            static let object5 = TermDefinition(term: "Type 5", definition: "")
            static let object6 = TermDefinition(term: "Type 6", definition: "")
        }
        
        /**
         Term / Definition combinations to be displayed for PopupButton 4 Info
         
         Notes:
         
         `SegueID : PopoverSegueInfo4`
         */
        struct Info4 {
            static let object1 = TermDefinition(term: "Type A", definition: "")
            static let object2 = TermDefinition(term: "Type B", definition: "")
            static let object3 = TermDefinition(term: "Type C", definition: "")
        }
    }
    
    struct SecondaryRegistrationVC {
        /**
         Term / Definition combinations to be displayed for Option checkbox buttons
         
         Notes:
         
         `SegueID : PopoverSegueOptionDescription`
         */
        struct Option {
            static let object1 = TermDefinition(term: "Option 1", definition: "")
            static let object2 = TermDefinition(term: "Option 2", definition: "")
            static let object3 = TermDefinition(term: "Option 3", definition: "")
            static let object4 = TermDefinition(term: "Option 4", definition: "")
            static let object5 = TermDefinition(term: "Option 5", definition: "")
            static let object6 = TermDefinition(term: "Option 6", definition: "")
            static let none = TermDefinition(term: "None of the above", definition: "")
        }
    }
}
