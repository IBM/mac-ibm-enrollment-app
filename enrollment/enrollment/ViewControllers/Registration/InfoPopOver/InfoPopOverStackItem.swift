//
//  InfoPopOverStackItem.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/16/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the stack item that will be showd in an infoPopover.
class InfoPopOverStackItem: NSView, LoadableNib {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var containerView: NSView!
    @IBOutlet var leftText: NSTextField! {
        didSet {
            guard let text = infoLabel else { return }
            leftText.stringValue = text
        }
    }
    @IBOutlet var rightText: NSTextField! {
        didSet {
            guard let text = infoDescription else { return }
            rightText.stringValue = text
        }
    }
    @IBOutlet var separatorCenter: NSLayoutConstraint! {
        didSet {
            separatorCenter.isActive = false
            separatorCenter = NSLayoutConstraint(item: separator!, attribute: .centerX, relatedBy: .equal, toItem: separator.superview!, attribute: .centerX, multiplier: separatorMultiplierValue!, constant: 0)
            separatorCenter.isActive = true
        }
    }
    @IBOutlet weak var separator: NSBox!

    // MARK: - Variables
    
    var infoLabel: String?
    var infoDescription: String?
    var separatorMultiplierValue: CGFloat?
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Initialize the stack item with the information of the infoSection row.
    /// - Parameters:
    ///   - label: the label of the row.
    ///   - description: the description of the row. If nil or not set the row will display only the label in full size.
    ///   - separatorMultiplierValue: the multiplier value that handle the position of an hidden separator between the label and the description.
    init(with field: InfoField, separatorMultiplierValue: CGFloat? = 0.60) {
        self.infoLabel = field.label.localized
        if let description = field.description?.localized, !description.isEmpty {
            self.infoDescription = description
            self.separatorMultiplierValue = separatorMultiplierValue
        } else {
            self.infoDescription = ""
            self.separatorMultiplierValue = 1.9
        }
        super.init(frame: .zero)
        loadViewFromNib()
    }
}
