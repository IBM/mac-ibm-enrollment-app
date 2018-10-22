//
//  UpdateAppBundleInstallationUI.swift
//  enrollment
//
//  Created by Jay Latman on 9/4/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class UpdateUIForAppStatus{
    var appStatusKey = String()
    var appIndicator = CircularStatus()
    var anchorStop = Int()
    var totalBundleResult = [Double]()
    var index = Int()
    
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
