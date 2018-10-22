//
//  MainStoryboardConstants.swift
//  enrollment
//
//  Created by Jay Latman on 12/4/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import Cocoa

enum MainStoryboard {
    static let name = "Main"
    
    static func storyboard() -> NSStoryboard {
        return NSStoryboard(name: name, bundle: nil)
    }
    
    enum SegueIdentifier: String {
        case contentContainerSegue
    }
    
    enum WindowControllerIdentifier : String {
        case PrimaryRegistrationChildViewController
        
        func instatiateWindowController() -> NSWindowController? {
            return MainStoryboard.storyboard().instantiateController(withIdentifier: self.rawValue) as? NSWindowController
        }
    }
}
