//
//  ExtendedRegistrationFieldItem.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/25/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the single option item of the extended registration field.
class ExtendedRegistrationFieldItem: NSView, LoadableNib {

    // MARK: - Outlets
    
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var optionItem: NSButton!
    
    // MARK: - Variables
    
    var fieldOption: RegistrationField.Option? {
        didSet {
            guard let option = fieldOption else { return }
            optionItem.title = option.label.localized
        }
    }
    var isSelected: Bool = false {
        didSet {
            optionItem.state = isSelected ? .on : .off
        }
    }
    /// Call back that pass the option and the checkBox state to the parent class.
    var onSelection: (RegistrationField.Option, NSControl.StateValue) -> Void = { _, _ in }
    
    // MARK: - Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    // MARK: - Actions
    
    @IBAction func didSelectOption(_ sender: NSButton) {
        guard let option = fieldOption else { return }
        self.onSelection(option, sender.state)
    }
}
