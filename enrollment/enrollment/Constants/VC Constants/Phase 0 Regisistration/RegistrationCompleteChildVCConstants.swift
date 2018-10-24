//
//  RegistrationCompleteChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct RegistrationCompleteChildVC_Constants {
    static let header = "Registration complete"
    static let subheader = "Let's get your Mac set up!"
    static let initialCountdownValue = 5
    static let countdownMessage = "Your Mac will be restarted automatically in \(RegistrationCompleteChildVC_Constants.initialCountdownValue) minutes to continue the setup process."
    static let instructionalMessage = "After your next log in, you'll be prompted for a new macOS login password and to enable FileVault disk encryption."
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     - Note: these are text string values to be displayed in the event of restart command failure.
     
     • `message`: string value to be displayed to the user
     
     • `comment`: string value to be potentially recorded by the app
     */
    struct FailureToRestart {
        static let message = "Your computer could not be restarted"
        static let comment = "Restart failure alert"
    }
}
