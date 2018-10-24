//
//  HeaderViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/22/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class HeaderViewController: NSViewController, StackItemHeader {

    @IBOutlet weak var bundleProgressIndicator: CircularStatus!
    @IBOutlet weak var headerTextLabel: NSTextField!
    @IBOutlet weak var statusTextLabel: NSTextField!
    @IBOutlet weak var discloseButton: NSButton!
    
    var disclose: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
    }
    
    internal func setTextFields() {
        headerTextLabel.set(label: title!, color: .headerTextColor)
        statusTextLabel.textColor = .controlTextColor
    }
    
    internal func update(toDiscloseState: StackItemContainer.DiscloseState) {
        switch toDiscloseState {
        case .open:
            discloseButton.title = BundleInstallationChildVC_Constants.DisclosureButtonLabelText.open
        case .closed:
            discloseButton.title = BundleInstallationChildVC_Constants.DisclosureButtonLabelText.closed
        }
        discloseButton.set(textColor: .linkColor, underline: NSUnderlineStyle.init(rawValue: 0).rawValue)
    }
    
    internal func updateWithProgressIndicatorAndMessage(progressIndicator: StatusState, statusText: String) {
        statusTextLabel.fadeTransition(0.20)
        bundleProgressIndicator.fadeTransition(0.20)
        statusTextLabel.stringValue = statusText
        bundleProgressIndicator.state = progressIndicator
    }
    
    internal func updateWithProgressMessage(statusText: String) {
        statusTextLabel.fadeTransition(0.20)
        statusTextLabel.stringValue = statusText
    }
    
    internal func updateWithProgressIndicator(progressIndicator: StatusState) {
        bundleProgressIndicator.fadeTransition(0.20)
        bundleProgressIndicator.state = progressIndicator
    }
    
    @IBAction func discloseButtonClicked(_ sender: NSButton) {
        disclose?()
    }
    
}
