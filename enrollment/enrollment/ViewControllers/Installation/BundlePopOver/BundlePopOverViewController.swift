//
//  BundlePopOverViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/29/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the view controller that should show the bundle information as popover.
class BundlePopOverViewController: NSViewController {
   
    // MARK: - Outlets
    
    @IBOutlet var headerTextLabel: NSTextField!
    @IBOutlet var descriptionTextLabel: NSTextField!
    @IBOutlet var collectionView: NSCollectionView!
    
    // MARK: - Variables
    
    var bundle: EnrollmentBundle
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureCollectionView()
    }
    
    // MARK: - Initializers
    
    /// Initialize the popover viewcontroller with the bundle that needs to be showed.
    /// - Parameter bundle: the given bundle.
    init(with bundle: EnrollmentBundle) {
        self.bundle = bundle
        super.init(nibName: .init("BundlePopOverViewController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configureCollectionView() {
        collectionView.register(NSNib(nibNamed: "BundleItemCell", bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier("BundleItemCell"))
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureLabels() {
        headerTextLabel.alignment = .center
        headerTextLabel.textColor = .headerTextColor
        descriptionTextLabel.alignment = .center
        descriptionTextLabel.textColor = .headerTextColor
        headerTextLabel.stringValue = bundle.title.localized
        descriptionTextLabel.stringValue = bundle.description.localized
    }
}

// MAKR: - Collection View delegate, data source and flow layout delegate.

extension BundlePopOverViewController: NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BundleItemCell"), for: indexPath as IndexPath) as? BundleItemCell,
            indexPath.item < bundle.apps.count else { return NSCollectionViewItem() }
        
        let app = bundle.apps[indexPath.item]
        cell.configure(with: app)
        
        return cell
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bundle.apps.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        
        return NSEdgeInsets(top: 0, left: 0.5, bottom: 0, right: 0.5)
    }
}
