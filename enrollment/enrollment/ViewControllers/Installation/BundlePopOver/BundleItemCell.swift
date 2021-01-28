//
//  BundleItemCell.swift
//  enrollment
//
//  Created by Jay Latman on 8/17/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the cell that represent the bundle app.
class BundleItemCell: NSCollectionViewItem {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bundleItemImage: NSImageView!
    @IBOutlet weak var bundleItemTitleLabel: NSTextField!
    @IBOutlet weak var bundleItemDescriptionLabel: NSTextField!
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        configureView()
        configureLabels()
    }
    
    // MARK: - Public methods
    
    /// Thsi method configure the cell with the ginven app informations.
    /// - Parameter app: the given app.
    func configure(with app: EnrollmentBundle.App) {
        bundleItemTitleLabel.stringValue = app.title.localized
        bundleItemImage.image = NSImage(named: app.icon)
        bundleItemDescriptionLabel.stringValue = app.description.localized
    }
    
    // MARK: - Private methods
    
    private func configureLabels() {
        bundleItemTitleLabel.textColor = .headerTextColor
        bundleItemDescriptionLabel.textColor = .controlTextColor
    }
    
    private func configureView() {
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 5
    }
}
