//
//  BundleItemCell.swift
//  enrollment
//
//  Created by Jay Latman on 8/17/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class BundleItemCell: NSCollectionViewItem {
    
    @IBOutlet weak var bundleItemImage: NSImageView!
    @IBOutlet weak var bundleItemTitleLabel: NSTextField!
    @IBOutlet weak var bundleItemDescriptionLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        layoutSetup()
    }
    
    private func layoutSetup() {
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 5
        bundleItemTitleLabel.textColor = .headerTextColor
        bundleItemDescriptionLabel.textColor = .controlTextColor
    }
}
