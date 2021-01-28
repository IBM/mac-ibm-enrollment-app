//
//  AppInstallationStackViewItem.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/16/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class AppInstallationStackViewItem: NSView, LoadableNib {

    // MARK: - Outlets
    
    @IBOutlet weak var loaderView: LoaderView!
    @IBOutlet weak var appNameLabel: NSTextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var contentView: NSView!
    
    // MARK: - Variables
    
    var app: EnrollmentBundle.App!
    public var isVisible: Bool = false {
        didSet {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                context.duration = 0.10
                context.allowsImplicitAnimation = true
                heightConstraint.animator().constant = isVisible ? 16 : 0
                topMargin.animator().constant = isVisible ? 4 : 0
                bottomMargin.animator().constant = isVisible ? 4 : 0
                layoutSubtreeIfNeeded()
            }, completionHandler: {
                if self.isVisible {
                    DispatchQueue.main.async {
                        self.loaderView.state = self.translatedBundleStatus()
                    }
                }
            })
        }
    }
    
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
    
    func configure(with app: EnrollmentBundle.App) {
        self.app = app
        appNameLabel.stringValue = app.title.localized
        loaderView.state = translatedBundleStatus()
        heightConstraint.constant = 0
        topMargin.constant = 0
        bottomMargin.constant = 0
        layoutSubtreeIfNeeded()
    }
    
    func updateApp(with newStatus: EnrollmentBundle.InstallationStatus) {
        guard app.status != newStatus else { return }
        app.status = newStatus
        loaderView.state = translatedBundleStatus()
    }
    
    // MARK: - Private methods
    
    private func translatedBundleStatus() -> LoaderView.State {
        switch app.status {
        case .installationPending:
            return .inQueue
        case .installationInProgress:
            return .inProgress
        case .installed:
            return .success
        case .errorDuringInstallation:
            return .failure
        default:
            return .inQueue
        }
    }
}
