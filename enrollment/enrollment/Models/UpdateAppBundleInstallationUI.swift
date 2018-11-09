//
//  UpdateAppBundleInstallationUI.swift
//  enrollment
//
//  Created by Jay Latman on 9/4/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Class definition for updating the UI with the app installation progress used on the Bundle Installation Child View Controller
 */
class UpdateUIForAppStatus{
    var appStatusKey = String()
    var appIndicator = CircularStatus()
    var anchorStop = Int()
    var totalBundleResult = [Double]()
    var index = Int()
    
    /**
     Class initializer for updating the installation progress UI
     
     - Parameter appStatusKey : string value for referencing the app bundle status property list key and value
     - Parameter appIndicator : `CircularStatus` indicator
     - Parameter anchorStop : integer value for anchoring the indicator to keep it positioned properly
     - Parameter totalBundleResult : [Array] of doubles containing the values of 0.0 or 1.0 for each item in the bundle (0.0 = failure and 1.0  success)
     - Parameter index : integer value pertaining to the index value for the paricular app in the bundle array
    */
    init(appStatusKey: String, appIndicator: CircularStatus, anchorStop: inout Int, totalBundleResult: inout [Double], index: Int) {
        self.appStatusKey = appStatusKey
        self.appIndicator = appIndicator
        self.anchorStop = anchorStop
        self.totalBundleResult = totalBundleResult
        self.index = index
        
        if let appObject = UserDefaults.standard.value(forKey: appStatusKey) {
            switch String(describing: appObject) {
            case "0" :
                appIndicator.state = .appInQueue
            case "1" :
                appIndicator.state = .appInProgressAnimated
                if anchorStop == 0 {
                    appIndicator.determineAnchorPoint(indicator: appIndicator)
                }
                anchorStop = 1
                appIndicator.rotate()
            case "2" :
                appIndicator.stopRotation()
                appIndicator.state = .appSuccess
                totalBundleResult[index] = 1.0
            case "3" :
                appIndicator.stopRotation()
                appIndicator.state = .appFailure
                totalBundleResult[index] = 0.0
            default:
                appIndicator.state = .appInQueue
            }
        }
    }
}
