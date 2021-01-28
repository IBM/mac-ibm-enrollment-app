//
//  BundleInstallationCell.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/14/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This protocol provide an interface between the bundle cell and the collection view controller.
protocol BundleInstallationStackViewItemDelegate: class {
    func didPressShowHideButton(_ sender: BundleInstallationStackViewItem)
}

class BundleInstallationStackViewItem: NSView, LoadableNib {
    
    // MARK: - Outlets
    @IBOutlet weak var loaderView: LoaderView!
    @IBOutlet weak var bundleTitleLabel: NSTextField!
    @IBOutlet weak var bundleMessageLabel: NSTextField!
    @IBOutlet weak var showHideButton: NSButton!
    @IBOutlet weak var contentView: NSView!
    @IBOutlet weak var headerContainerView: NSView!
    
    // MARK: - Variables
    
    var bundle: EnrollmentBundle!
    weak var delegate: BundleInstallationStackViewItemDelegate?
    var isExpanded: Bool = false
    
    // MARK: - Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    // MARK: - Public methods
    
    /// This method configure the cell with the information of the given bundle.
    /// - Parameter bundle: the given bundle.
    func configure(with bundle: EnrollmentBundle, isExpanded: Bool = false) {
        self.bundle = bundle
        self.isExpanded = isExpanded
        configureView()
    }
    
    func updateBundle(with newStatus: EnrollmentBundle.InstallationStatus) {
        bundle.status = newStatus
        loaderView.state = translatedBundleStatus()
    }
    
    func updateBundle(with newMessage: String) {
        bundle.bundleMessaging = newMessage
        bundleMessageLabel.stringValue = newMessage
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        bundleTitleLabel.stringValue = bundle.title.localized
        configureBundleInstallationStatus()
    }
    
    private func configureBundleInstallationStatus() {
        bundleMessageLabel.stringValue = bundle.bundleMessaging ?? ""
        showHideButton.title = isExpanded ? "HideApp" : "ShowApp"
        loaderView.state = translatedBundleStatus()
    }
    
    private func translatedBundleStatus() -> LoaderView.State {
        switch bundle.status {
        case .installationPending:
            return .inQueue
        case .installationInProgress:
            return .inProgress
        case .installed, .errorDuringInstallation:
            let bundleAppStatus = bundle.apps.map({ $0.status })
            return (bundleAppStatus.contains(.errorDuringInstallation) ? (bundleAppStatus.contains(.installed) ? .partial : .failure) : .success)
        default:
            return .inQueue
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didPressShowHideButton(_ sender: NSButton) {
        isExpanded.toggle()
        showHideButton.title = isExpanded ? "HideApp" : "ShowApp"
        delegate?.didPressShowHideButton(self)
    }
}
