//
//  SecondaryRegistrationChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 7/25/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class SecondaryRegistrationChildViewController: NSViewController {

    // Transition button outlets
    @IBOutlet weak var continueToNextStepButton: NSButton!
    
    // Text outlets
    @IBOutlet weak var headerTextLabel: NSTextField!
    @IBOutlet weak var subheaderTextLabel: NSTextField!
    
    // Info bubble outlets
    @IBOutlet weak var infoBubbleButton: NSButton!
    
    // Checkbox button outlets
    @IBOutlet weak var optionCheckbox1: NSButton!
    @IBOutlet weak var optionCheckbox2: NSButton!
    @IBOutlet weak var optionCheckbox3: NSButton!
    @IBOutlet weak var optionCheckbox4: NSButton!
    @IBOutlet weak var optionCheckbox5: NSButton!
    @IBOutlet weak var optionCheckbox6: NSButton!
    @IBOutlet weak var noneOfTheAboveCheckbox: NSButton!
    
    var optionCheckboxButtons: [NSButton]!
    var optionCheckboxSelected: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
        if (UserDefaults.standard.array(forKey: SecondaryRegistrationChildVC_Constants.Keys.Options.optionArray)) != nil {
            loadOnOffStateFromPlist()
        } else { return }
        setStateForContinueToNextStepButton()
    }
    
    
    private func layoutSetup() {
        infoBubbleButton.image = InfoBubble.imageOfInfo_bubble
        optionCheckbox1.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object1.term, underline: 0)
        optionCheckbox2.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object2.term, underline: 0)
        optionCheckbox3.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object3.term, underline: 0)
        optionCheckbox4.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object4.term, underline: 0)
        optionCheckbox5.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object5.term, underline: 0)
        optionCheckbox6.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.object6.term, underline: 0)
        noneOfTheAboveCheckbox.set(toggleLabel: " " + InfoPopoverConstants.SecondaryRegistrationVC.Option.none.term, underline: 0)
        optionCheckboxButtons = [optionCheckbox1, optionCheckbox2, optionCheckbox3, optionCheckbox4, optionCheckbox5, optionCheckbox6]
    }
    
    private func setTextFields() {
        headerTextLabel.set(label: SecondaryRegistrationChildVC_Constants.header, color: .headerTextColor)
        subheaderTextLabel.set(label: SecondaryRegistrationChildVC_Constants.subheader, color: .controlTextColor )
    }
        
    private func loadOnOffStateFromPlist() {
        var optionCheckboxToggleArray: [String] = []
        
        if let optionCheckboxSelection = (UserDefaults.standard.array(forKey: SecondaryRegistrationChildVC_Constants.Keys.Options.optionArray)) as? [String] {
            for optionCheckboxToggles in optionCheckboxSelection {
                optionCheckboxToggleArray.append(optionCheckboxToggles)
                
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.one) { optionCheckbox1.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.two) { optionCheckbox2.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.three) { optionCheckbox3.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.four) { optionCheckbox4.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.five) { optionCheckbox5.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.six) { optionCheckbox6.state = .on }
                if optionCheckboxToggleArray.contains(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.none) { noneOfTheAboveCheckbox.state = .on }
            }
        }
    }
    
    private func setStateForContinueToNextStepButton() {
        let anyOptionSelected = optionCheckboxButtons.reduce(false) { $1.state == NSButton.StateValue.on ? true : $0 }
        
        if anyOptionSelected {
            self.noneOfTheAboveCheckbox.state = .off
        }
        self.continueToNextStepButton.fadeTransition(0.25)
        self.continueToNextStepButton.isEnabled = anyOptionSelected || self.noneOfTheAboveCheckbox.state == .on
    }
    
    @IBAction func optionToggled(_ sender: NSButton) {
        if (sender.identifier!.rawValue as String?) != SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.none {
            optionCheckboxSelected.remove(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.none)
            if sender.state == .on {
                optionCheckboxSelected.insert(sender.identifier!.rawValue as String)
                UserDefaults.standard.set(Array(optionCheckboxSelected), forKey: SecondaryRegistrationChildVC_Constants.Keys.Options.optionArray)
            } else {
                optionCheckboxSelected.remove(sender.identifier!.rawValue as String)
            }
            setStateForContinueToNextStepButton()
        }
        UserDefaults.standard.set(Array(optionCheckboxSelected), forKey: SecondaryRegistrationChildVC_Constants.Keys.Options.optionArray)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func noneOptionToggled(_ sender: NSButton) {
        if noneOfTheAboveCheckbox.state == .on {
            optionCheckboxButtons.forEach { $0.state = .off}
            self.setStateForContinueToNextStepButton()
            optionCheckboxSelected.removeAll()
            optionCheckboxSelected.insert(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.none)
        } else {
            self.setStateForContinueToNextStepButton()
            optionCheckboxSelected.remove(SecondaryRegistrationChildVC_Constants.Keys.Options.PersistenceStoredSelectedOption.none)
        }
        UserDefaults.standard.set(Array(optionCheckboxSelected), forKey: SecondaryRegistrationChildVC_Constants.Keys.Options.optionArray)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func infoBubbleButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.SecondaryRegistrationChildViewController.optionDescriptions, sender: self)
    }
    
    @IBAction func backButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.ReturnTo.primaryRegistrationChildViewController, sender: self)
    }
    
    @IBAction func continueToNextStepButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.ForwardTo.progressRegistrationChildViewController, sender: self)
    }
}
