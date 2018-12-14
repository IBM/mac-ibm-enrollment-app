//
//  Constants.swift
//  enrollment
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Structure definition containing reference assignments of stored constants mapped to color swatches in the asset catalog
 
 child structs:
 
 Indicators, LinkButton, AppBundle, Registration, BackgroundColor, SetupComplete
 */
struct ColorConstants {
    /**
     Indicator color definitions from the asset catalog assigned in Indicators.swift
     
     child structs:
     
     Success, Failure, Partial, Queued, Active
     */
    struct Indicators {
        /// Sucessful install indicator for app or bundle color assignments for each part of the drawn shape
        struct Success {
            static let ovalStroke = NSColor(named: "success_oval_stroke")
            static let ovalFill = NSColor(named: "success_oval_fill")
            static let checkStroke = NSColor(named: "success_check_stroke")
            static let checkFill = NSColor(named: "success_check_fill")
        }
        
        /// Failure to install indicator for app or bundle complete indicator color assignments for each part of the drawn shape
        struct Failure {
            static let fill = NSColor(named: "failure")
        }
        
        /// Partial completion indicator for bundle install color assignments for each part of the drawn shape
        struct Partial {
            static let fill = NSColor(named: "partial_oval_fill")
            static let dashFill = NSColor(named: "partial_dash")
        }
        
        /// Queued bundle or app indicator color assignments for each part of the drawn shape
        struct Queued {
            static let ovalStroke = NSColor(named: "queued_oval_stroke")
        }
        
        /// Active bundle or app indicator color assignments for each part of the drawn shape
        struct Active {
            static let ovalStroke = NSColor(named: "active_oval_stroke")
        }
    }
    
    /// Info button color assignments for each part of the drawn shape
    struct InfoButton {
        static let stroke = NSColor(named: "infoButtonStroke")
        static let background = NSColor(named: "infoButtonBackground")
        static let color = NSColor(named: "infoButtonColor")
    }
    
    /// Stored color assignments for the disclosure text buttons for bundle items used during the install process
    struct LinkButton {
        static let retry = NSColor(named: "retry_link_button")
        static let disclosure = NSColor(named: "disclosure_link_button")
        static let completionButtonDescription = NSColor(named: "completion_button_description")
    }
    
    /// General background color assignment for backing layers
    struct BackgroundColor {
        static let standard = "standard_bg_color"
        static let popover = ([NSColor(named: "popover_bg_color")] as! [NSColor])
    }
    
    /// Stored color assignments for interface elements in the Registration phase of the application
    struct Registration {
        static let checkBoxLabel = NSColor(named: "check_box_label")
    }
    
    /// Stored color assignments for interface elements in the AppBundle Selection phase of the application
    struct AppBundle {
        static let title = NSColor(named: "bundle_title")
        static let description = NSColor(named: "bundle_description")
        static let recommendedLabel = NSColor(named: "recommended_label")
    }
    
    /**
     Stored color assignments for interface elements used in the Setup Completion phase of the application
     
     Color references for drawn objects used in the SetupComplete view:
     
     • appleLogo : color for apple logo displayed in `MigrationButton`
     
     • outerRing : universal outer ring color
     
     • weblinkTextColor : color applied to `Hyperlink` text buttons for LinkOuts
     
     • descriptionTextColor : color applied to description text for each web link
     
     child structs -
     
     WebURLButton, MigrationButton, SelfServiceButton, HelpButton, BackupButton
     */
    struct SetupComplete {
        static let appleLogo = NSColor(named: "apple_logo_color")
        static let outerRing = NSColor.systemGray
        static let weblinkTextColor = NSColor.systemBlue
        static let descriptionTextColor = NSColor.systemGray
        
        /// WebURLButton color assignments for each part of the drawn shape
        struct WebURLButton {
            static let closeButton = NSColor(named: "web_close_button")
            static let maximizeButton = NSColor(named: "web_maximize_button")
            static let minimizeButton = NSColor(named: "web_minimize_button")
            static let windowBackground = NSColor(named: "web_window_background")
            static let windowStroke = NSColor(named: "web_window_stroke")
            static let innerRing = NSColor(named: "web_inner_ring")
        }
        
        /// MigrationButton color assignments for each part of the drawn shape
        struct MigrationButton {
            static let arrow_and_Keyboard = NSColor(named: "arrow_and_keyboard")
            static let screenBezel = NSColor(named: "screen_bezel")
            static let laptopScreenBackground = NSColor(named: "laptop_screen_background")
            static let innerRing = NSColor(named: "migration_inner_ring")
        }
        
        /// SelfServiceButton color assignments for each part of the drawn shape
        struct SelfServiceButton {
            static let upperRight = NSColor(named: "jamf_upper_right")
            static let upperLeft = NSColor(named: "jamf_upper_left")
            static let lowerRight = NSColor(named: "jamf_lower_right")
            static let lowerLeft = NSColor(named: "jamf_lower_left")
            static let innerRing = NSColor(named: "jamf_inner_ring")
        }
        
        /// HelpButton color assignments for each part of the drawn shape
        struct HelpButton {
            static let innerRing = NSColor(named: "help_inner_ring")
            static let windowBackground = NSColor(named: "help_background")
            static let checkmark = NSColor(named: "help_checkmark")
            static let bubbleStroke = NSColor(named: "help_bubble_stroke")
            static let questionMark = NSColor(named: "help_question_mark")
        }
        
        /// BackupButton color assignments for each part of the drawn shape
        struct BackupButton {
            static let innerRing = NSColor(named: "backup_inner_ring")
            static let clockhands_and_Arrowhead = NSColor(named: "clockhands_and_arrowhead")
            static let arrowTail = NSColor(named: "arrow_tail")
        }
    }
}
