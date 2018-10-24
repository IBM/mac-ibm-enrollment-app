//
//  SubViewControllerManagerViewController.swift
//  enrollment
//
//  Created by Jay Latman on 7/23/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 NSViewController class for managing the start points of the application.
 
 Enrollment has three primary phases:
 
 - Registration
 - App Bundle Selection and Installation
 - Helpful links for information
 */
class SubViewControllerManagerViewController: NSViewController {

    var storyboardID : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSetup()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    func layoutSetup() {
        if let startPoint = (UserDefaults.standard.string(forKey: StartingPointID.UserDefaultsKey.phase)) {
            switch String(describing: startPoint) {
            case "0" :
                storyboardID = StartingPointID.primaryRegistrationChildViewController
            case "1" :
                storyboardID = StartingPointID.bundleSelectionChildViewController
            case "2" :
                storyboardID = StartingPointID.setupCompleteChildViewController
            default:
                storyboardID = StartingPointID.primaryRegistrationChildViewController
            }
        }
        else {
            storyboardID = StartingPointID.primaryRegistrationChildViewController
        }

        let mainStoryboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let sourceViewController = mainStoryboard.instantiateController(withIdentifier: storyboardID!) as! NSViewController
        self.insertChild(sourceViewController, at: 0)
        self.view.addSubview(sourceViewController.view)
        self.view.frame = sourceViewController.view.frame
    }
}
