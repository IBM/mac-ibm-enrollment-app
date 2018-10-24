//
//  OptionPopover.swift
//  enrollment
//
//  Created by Jay Latman on 7/31/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class OptionPopover: NSViewController {

    // Left Column
    @IBOutlet weak var obj1Left: NSTextField!
    @IBOutlet weak var obj2Left: NSTextField!
    @IBOutlet weak var obj3Left: NSTextField!
    @IBOutlet weak var obj4Left: NSTextField!
    @IBOutlet weak var obj5Left: NSTextField!
    @IBOutlet weak var obj6Left: NSTextField!
    
    // Right Column
    @IBOutlet weak var obj1Right: NSTextField!
    @IBOutlet weak var obj2Right: NSTextField!
    @IBOutlet weak var obj3Right: NSTextField!
    @IBOutlet weak var obj4Right: NSTextField!
    @IBOutlet weak var obj5Right: NSTextField!
    @IBOutlet weak var obj6Right: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defineObjects()
    }
    
    func defineObjects() {
        let object1 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object1
        TermDefinition.assignTermDefinitionsToLabels(term: object1, leftLabel: obj1Left, rightLabel: obj1Right)
        
        let object2 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object2
        TermDefinition.assignTermDefinitionsToLabels(term: object2, leftLabel: obj2Left, rightLabel: obj2Right)
        
        let object3 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object3
        TermDefinition.assignTermDefinitionsToLabels(term: object3, leftLabel: obj3Left, rightLabel: obj3Right)
        
        let object4 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object4
        TermDefinition.assignTermDefinitionsToLabels(term: object4, leftLabel: obj4Left, rightLabel: obj4Right)
        
        let object5 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object5
        TermDefinition.assignTermDefinitionsToLabels(term: object5, leftLabel: obj5Left, rightLabel: obj5Right)
        
        let object6 = InfoPopoverConstants.SecondaryRegistrationVC.Option.object6
        TermDefinition.assignTermDefinitionsToLabels(term: object6, leftLabel: obj6Left, rightLabel: obj6Right)
    }
    
}
