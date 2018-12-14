//
//  SetupCompleteChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/6/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa
import ServiceManagement

class SetupCompleteChildViewController: NSViewController {
    
    @IBOutlet weak var headerMessageTextLabel: NSTextField!
    
    @IBOutlet weak var linkoutCollectionView: NSCollectionView!
    
    @IBOutlet weak var showOnRebootToggle: NSButton!
    
    let urlPath = Bundle.main
    let helperBundleIdentifier = SetupCompleteChildVC_Constants.helperBundleIdentifier
    
    var listOfIcons = [NSImage]()
    var listOfLinkOutHeaders = [String]()
    var listOfURLs = [String]()
    var listOfLinkDescriptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
    }
    
    private func layoutSetup() {
        let foundHelper = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == helperBundleIdentifier
        }
        showOnRebootToggle.state = foundHelper ? .on : .off
        
        listOfIcons = SetupCompleteChildVC_Constants.LinkOuts.icons
        listOfLinkOutHeaders = SetupCompleteChildVC_Constants.LinkOuts.headerLabels
        listOfLinkDescriptions = SetupCompleteChildVC_Constants.LinkOuts.descriptionLabels
        listOfURLs = SetupCompleteChildVC_Constants.LinkOuts.urls
        linkoutCollectionView.dataSource = self
        linkoutCollectionView.delegate = self
    }
    
    private func setTextFields() {
        headerMessageTextLabel.set(label: SetupCompleteChildVC_Constants.header, color: .headerTextColor)
        showOnRebootToggle.set(toggleLabel: SetupCompleteChildVC_Constants.showOnRestartToggleLabel, underline: 0)
    }
    
    
    @IBAction func showOnRebootToggleClicked(_ sender: NSButton) {
        let autoLaunch = showOnRebootToggle.state == .on
        if SMLoginItemSetEnabled(helperBundleIdentifier as CFString, autoLaunch) {
            if autoLaunch {
                NSLog("Login item added")
            } else {
                NSLog("Login item removed")
            }
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: NSButton) {
        exit(0)
    }
}

extension SetupCompleteChildViewController: NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfLinkOutHeaders.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let linkOutItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LinkOutItemCell"), for: indexPath as IndexPath) as? LinkOutItemCell
        linkOutItem?.linkoutItemImage.image = self.listOfIcons[indexPath.item]
        linkOutItem?.linkoutItemHeaderLabel.stringValue = self.listOfLinkOutHeaders[indexPath.item]
        linkOutItem?.linkoutItemHeaderLabel.href = self.listOfURLs[indexPath.item]
        linkOutItem?.linkoutItemDescriptionLabel.stringValue = self.listOfLinkDescriptions[indexPath.item]

        return linkOutItem!
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        return NSEdgeInsets(top: 0.1, left: 0, bottom: 0.1, right: 0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 460, height: 60)
    }
}
