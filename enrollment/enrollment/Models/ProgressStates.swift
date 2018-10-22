//
//  ProgressStates.swift
//  enrollment
//
//  Created by Jay Latman on 8/7/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

/**
 Enumeration of progress states
 
 - waiting:    Waiting, not running
 - inProgress: In Progress
 - success:    Successfull completed
 - failure:    Completed with error
 */
enum StatusState: Int {
    case appInQueue
    case appInProgress
    case appInProgressAnimated
    case appSuccess
    case appFailure
    case inQueue
    case inProgress
    case inProgressAnimated
    case success
    case partial
    case failure
    
    
    /// Indicates whether the state indicates completion
    var isComplete: Bool {
        get {
            return self == .success || self == .failure || self == .partial
        }
    }
}
