//
//  ConfigurationErrorViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 5/21/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class ConfigurationErrorViewController: NSViewController {
    
    // MARK: Variables
    
    private var errorMessage: String
    @IBOutlet weak var errorLabel: NSTextField!
    @IBOutlet weak var bottomRightButton: NSButton!
    
    // MARK: Initializers
    
    init(with errorMessage: String) {
        self.errorMessage = errorMessage
        super.init(nibName: "ConfigurationErrorViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Instance methods
    
    override func viewWillAppear() {
        super.viewWillAppear()
        errorLabel.stringValue = errorMessage
        bottomRightButton.title = "buttonLabelClose".localized
    }
    
    // MARK: Actions
    
    @IBAction func didPressedBottomRightButton(_ sender: NSButton) {
        exit(0)
    }
}
