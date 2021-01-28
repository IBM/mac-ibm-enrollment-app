//
//  InfoLabelView.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/3/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class provide a label with a built in info button.
class InfoLabelView: NSView, LoadableNib {

    // MARK: - Outlets
    
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var labelText: NSTextField!
    @IBOutlet weak var infoButton: NSButton!
    
    // MARK: - Variables
    
    /// This call back send to the parent view the reference of the button that triggered the action.
    /// This reference will be used to obtain the correct rect to show the informations popover
    var onInfoButtonPressed: ((NSButton) -> Void)?
    var labelledInfo: InfoLabel? {
        didSet {
            guard let info = labelledInfo else { return }
            if let attributedLabel = info.attributedLabel {
                labelText.attributedStringValue = attributedLabel
            } else {
                labelText.stringValue = info.label.localized
            }
            infoButton.isHidden = info.infoSection == nil
        }
    }
    /// The developer can define the different fonts for the label.
    var font: NSFont? {
        didSet {
            labelText.font = font
        }
    }

    // MARK: - Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    // MARK: - Actions
    
    @IBAction func infoButtonDidPressed(_ sender: NSButton) {
        self.onInfoButtonPressed?(sender)
    }
}
