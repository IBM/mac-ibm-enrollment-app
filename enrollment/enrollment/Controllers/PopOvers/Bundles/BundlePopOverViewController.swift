//
//  BundlePopOverViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/29/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa


class BundlePopOverViewController: NSViewController {
   
    @IBOutlet var headerTextLabel: NSTextField!
    @IBOutlet var descriptionTextLabel: NSTextField!
    @IBOutlet var collectionView: NSCollectionView!
    
    var recievedBundleTitleString = String()
    var recievedBundleDescriptionString = String()
    var recievedListOfTitles = [String]()
    var recievedListOfIcons = [NSImage]()
    var recievedListOfDescriptions = [String]()
    
    var listOfIcons = [NSImage]()
    var listOfTitles = [String]()
    var listOfDescriptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        layoutSetup()
    }
    
    private func layoutSetup() {
        collectionView.backgroundColors = ColorConstants.BackgroundColor.popover
        headerTextLabel.alignment = .center
        headerTextLabel.textColor = .headerTextColor
        descriptionTextLabel.alignment = .center
        descriptionTextLabel.textColor = .headerTextColor
        headerTextLabel.stringValue = recievedBundleTitleString.capitalized
        descriptionTextLabel.stringValue = recievedBundleDescriptionString
        listOfIcons = recievedListOfIcons
        listOfTitles = recievedListOfTitles
        listOfDescriptions = recievedListOfDescriptions
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension BundlePopOverViewController: NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let bundleItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BundleItemCell"), for: indexPath as IndexPath) as? BundleItemCell
        
        bundleItem?.bundleItemTitleLabel.stringValue = self.listOfTitles[indexPath.item]
        bundleItem?.bundleItemImage.image = self.listOfIcons[indexPath.item]
        bundleItem?.bundleItemDescriptionLabel.stringValue = self.listOfDescriptions[indexPath.item]
        return bundleItem!
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTitles.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        
        return NSEdgeInsets(top: 0, left: 0.5, bottom: 0, right: 0.5)
    }
}
