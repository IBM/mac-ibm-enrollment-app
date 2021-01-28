//
//  MainViewController.swift
//  enrollment
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2017 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// Main view controller for the application.
class MainViewController: NSViewController {
    
    /// Image view for displaying art
    @IBOutlet weak var sidePanelImageView: NSImageView!
    
    /// View for views move / transition in and out
    @IBOutlet weak var contentContainerView: NSView!
    
    /// Width constraint of content container view for maintaining aspect so subviews are able to move in and out
    @IBOutlet weak var contentContainerWidthConstraint: NSLayoutConstraint!
    /// Height constraint of content container view for maintaining aspect so subviews are able to move in and out
    @IBOutlet weak var contentContainerHeightContraint: NSLayoutConstraint!
    
    /// Value registering what the view is currently loaded into the content container view
    fileprivate var currentConfigurationViewController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Validate if the jamf binary is present on launch
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == false {
            IssueAlertService.sharedInstance.displayModalFailureToLaunch(header: AlertText.FailureToLaunch.header,
                                                    message: AlertText.FailureToLaunch.message,
                                                    style: .critical,
                                                    cancelButtonLabel: "buttonLabelQuit".localized)
        }

        guard Context.main?.dataSet != nil else { return }
    }
    
    override func viewWillAppear() {
       super.viewWillAppear()
       layoutSetup()
    }
    
    private func layoutSetup() {
        self.currentConfigurationViewController?.view.setFrameSize(self.contentContainerView.bounds.size)
    }
}
