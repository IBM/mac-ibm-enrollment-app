//
//  LinkOutItemCell.swift
//  enrollment
//
//  Created by Jay Latman on 10/1/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class LinkOutItemCell: NSCollectionViewItem {

    @IBOutlet var linkoutItemImage: NSImageView!
    @IBOutlet var linkoutItemHeaderLabel: Hyperlink!
    @IBOutlet var linkoutItemDescriptionLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
    }
    
    private func layoutSetup() {
        self.view.wantsLayer = true
    }
    
    private func setTextFields() {
        linkoutItemHeaderLabel.textColor = .linkColor
        linkoutItemDescriptionLabel.textColor = .controlTextColor
    }
}
