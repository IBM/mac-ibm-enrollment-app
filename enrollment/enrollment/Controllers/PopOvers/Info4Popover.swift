//
//  Info4Popover.swift
//  enrollment
//
//  Created by Jay Latman on 7/27/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class Info4Popover: NSViewController {
    
    // Left Column
    @IBOutlet weak var obj1Left: NSTextField!
    @IBOutlet weak var obj2Left: NSTextField!
    @IBOutlet weak var obj3Left: NSTextField!
    
    
    // Right Column
    @IBOutlet weak var obj1Right: NSTextField!
    @IBOutlet weak var obj2Right: NSTextField!
    @IBOutlet weak var obj3Right: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defineObjects()
    }
    
    private func defineObjects() {
        let object1 = InfoPopoverConstants.PrimaryRegistrationVC.Info4.object1
            TermDefinition.assignTermDefinitionsToLabels(term: object1, leftLabel: obj1Left, rightLabel: obj1Right)
        
        let object2 = InfoPopoverConstants.PrimaryRegistrationVC.Info4.object2
            TermDefinition.assignTermDefinitionsToLabels(term: object2, leftLabel: obj2Left, rightLabel: obj2Right)
        
        let object3 = InfoPopoverConstants.PrimaryRegistrationVC.Info4.object3
            TermDefinition.assignTermDefinitionsToLabels(term: object3, leftLabel: obj3Left, rightLabel: obj3Right)
    }
}
