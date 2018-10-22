//
//  DefineBundleInfoPopover.swift
//  enrollment
//
//  Created by Jay on 8/30/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import AppKit

class DefineBundleInfoPopover {
    
    var bundleTitle = String()
    var descriptionText = String()
    var appTitles = [String]()
    var appDescriptions = [String]()
    var appIcons = [NSImage]()
    
    init(bundleTitle: String, bundleDescription: String, appTitles: [String], appDescriptions: [String], appIcons: [NSImage]) {
        self.bundleTitle = String(bundleTitle)
        self.descriptionText = String(bundleDescription)
        self.appTitles = appTitles
        self.appDescriptions = appDescriptions
        self.appIcons = appIcons
    }
}
