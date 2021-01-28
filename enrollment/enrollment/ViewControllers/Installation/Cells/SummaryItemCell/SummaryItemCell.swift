//
//  SummaryItemCell.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/23/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

protocol SummaryItemCellDelegate: class {
    func didPressItem(_ item: PostInstallationPage.Item)
}

/// This class handle the summary item.
class SummaryItemCell: NSCollectionViewItem {

    // MARK: - Outlets
    
    @IBOutlet weak var iconImageView: NSImageView!
    @IBOutlet weak var titleButton: LabelButton!
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    // MARK: - Variables
    
    static var reuseIdentifier = NSUserInterfaceItemIdentifier("SummaryItemCell")
    weak var delegate: SummaryItemCellDelegate?
    var rapresentedItem: PostInstallationPage.Item!
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public methods
    
    func configure(with item: PostInstallationPage.Item) {
        rapresentedItem = item
        iconImageView.image = NSImage(named: item.iconName)
        titleButton.title = item.title.localized
        descriptionLabel.stringValue = item.description.localized
    }
    
    // MARK: - Action
    
    @IBAction func didPressOnTitleButton(_ sender: LabelButton) {
        delegate?.didPressItem(rapresentedItem)
    }
}
