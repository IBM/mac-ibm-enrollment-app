//
//  AnimatedGIFProgressChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

struct AnimatedGIFProgressChildVC_Constants {
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     - Note: these are text string values to be displayed while the AnimatedGIFProgressView is active.
     
     • `stateOne`: first text string to be displayed
     
     • `stateTwo`: second text string to be displayed
     */
    struct RegistrationProgress {
        static let stateOne = "Testing network speed"
        static let stateTwo = "Completing enrollment"
    }
    
    /**
     Structure definition containing reference assignments of stored values or property list key names for retrieving values.
     - Note: GIF file to be displayed in the center of of the AnimatedGIFProgressView.
     
     • `fileName`: reference for gif file living in the asset catalog
     */
    struct AnimatedProgressGIF {
        static let fileName = ""
    }
}
