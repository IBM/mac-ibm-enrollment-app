//
//  SecondaryRegistrationChildVCConstants.swift
//  enrollment
//
//  Created by Jay Latman on 10/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct SecondaryRegistrationChildVC_Constants {
    static let header = "Lorem Ipsum"
    static let subheader = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
   
    
    /**
     Structure definition containing the key name assignments for storing the Option checkbox values
     
     • `optionArray` : key name for the array to store the options
     • `PersistenceStoredSelectedOption` : array values corresponding to the option choices that a user has selected
    */
    struct Keys {
        /**
        */
        struct Options {
            static let optionArray = "Options"
            struct PersistenceStoredSelectedOption {
                static let one = "1"
                static let two = "2"
                static let three = "3"
                static let four = "4"
                static let five = "5"
                static let six = "6"
                static let none = "none"
            }
        }
    }
}
