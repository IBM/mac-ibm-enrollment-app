//
//  InfoPopOverViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/16/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the popover that shows the informations related to a label.
class InfoPopOverViewController: NSViewController {
    
    // MAKR: - Outlets
    
    @IBOutlet var mainStackView: NSStackView!
    
    // MARK: - Variables
    
    var infoSection: InfoSection
    
    // MARK: - Initializers
    
    /// Initialize the popover with the infoSection that needs to be showed.
    /// - Parameter info: the InfoSection object that needs to be displayed ad popover.
    init(with info: InfoSection) {
        self.infoSection = info
        super.init(nibName: .init("InfoPopOverViewController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, field) in infoSection.fields.enumerated() {
            let itemView = InfoPopOverStackItem(with: field)
            self.mainStackView.insertArrangedSubview(itemView, at: index*2)
            guard index+1 < infoSection.fields.count else { return }
            let horizontalLine = HorizontalLine()
            let widthConstraint = NSLayoutConstraint(item: horizontalLine, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: mainStackView.frame.width-16)
            let heightConstraint = NSLayoutConstraint(item: horizontalLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1)
            horizontalLine.addConstraints([widthConstraint, heightConstraint])
            widthConstraint.isActive = true
            heightConstraint.isActive = true
            self.mainStackView.insertArrangedSubview(horizontalLine, at: (index*2)+1)
        }
    }
}
