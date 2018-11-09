//
//  DefineBundleInfoPopover.swift
//  enrollment
//
//  Created by Jay on 8/30/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import AppKit

/**
 Class definition for defining a software bundle info popover
 */
class DefineBundleInfoPopover {
    
    var bundleTitle = String()
    var descriptionText = String()
    var appTitles = [String]()
    var appDescriptions = [String]()
    var appIcons = [NSImage]()
    
    /**
     Class initializer for defining a bundle info popover.
     
     The appTitles, appDescriptions, and appIcons construct individual application cards based on array index position.
     
     - Parameter bundleTitle : string value for the bundle's name
     - Parameter bundleDescription : string value for a short description about the bundle (size is limited)
     - Parameter appTitles : [Array] of strings containing all the apps in a bundle
     - Parameter appDescriptions : [Array] of strings containing short descriptions for each app in the bundle (size is limited)
     - Parameter appIcons : [Array] of images from the asset catalog
    */
    init(bundleTitle: String, bundleDescription: String, appTitles: [String], appDescriptions: [String], appIcons: [NSImage]) {
        self.bundleTitle = String(bundleTitle)
        self.descriptionText = String(bundleDescription)
        self.appTitles = appTitles
        self.appDescriptions = appDescriptions
        self.appIcons = appIcons
    }
}
