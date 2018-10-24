//
//  PrimaryRegistrationChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 7/23/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 NSViewController class for the first Registration View.
 
 example: This view contains popup buttons for choices to be selected by the user to be used for external registration requirements.
 */
class PrimaryRegistrationChildViewController: NSViewController {
    
    @IBOutlet var primaryRegistrationView: NSView!
    
    // Transition button outlets
    @IBOutlet weak var continueToNextStepButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    // Text outlets
    @IBOutlet weak var welcomeMessage: NSTextField!
    @IBOutlet weak var nameErrorMessage: NSTextField!
    @IBOutlet weak var additionalPolicyMessage: NSTextField!
    
    // Info bubble outlets
    @IBOutlet weak var nameErrorInfoBubble: NSButton!
    @IBOutlet weak var popupBox2InfoBubble: NSButton!
    @IBOutlet weak var popupBox4InfoBubble: NSButton!
    @IBOutlet weak var additionalPolicyMessageInfoBubble: NSButton!
    
    // Popup button outlets : Header labels
    @IBOutlet weak var popupButton1Header: NSTextField!
    @IBOutlet weak var popupButton2Header: NSTextField!
    @IBOutlet weak var popupButton3Header: NSTextField!
    @IBOutlet weak var popupButton4Header: NSTextField!
    
    // Popup button outlets : contents
    @IBOutlet weak var popupButton1: NSPopUpButton!
    @IBOutlet weak var popupButton2: NSPopUpButton!
    @IBOutlet weak var popupButton3: NSPopUpButton!
    @IBOutlet weak var popupButton4: NSPopUpButton!
    
    
    
    /*
     We store the return values of each pull down selection to be sure all for values have been selected and corresponding coded values have been written to disc before enabling the 'continueToNextStepButton'. We can validate if the array contains a 0 to disable the button
    */
    var percentageOfCompletion: Array<Int> = [Int](repeating: 0, count: 4)
    
    var returnCODE = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        loadConfigurationStateFromPlist()
    }
    
    private func layoutSetup() {
        continueToNextStepButton.isEnabled = false
        popupButton1Header.stringValue = PrimaryRegistrationChildVC_Constants.PopupButtons.Headers.LabelText.popup1Header
        popupButton2Header.stringValue = PrimaryRegistrationChildVC_Constants.PopupButtons.Headers.LabelText.popup2Header
        popupButton3Header.stringValue = PrimaryRegistrationChildVC_Constants.PopupButtons.Headers.LabelText.popup3Header
        popupButton4Header.stringValue = PrimaryRegistrationChildVC_Constants.PopupButtons.Headers.LabelText.popup4Header
        popupButton1.addItems(withTitles: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.list)
        popupButton2.addItems(withTitles: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.list)
        popupButton3.addItems(withTitles: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.list)
        popupButton4.addItems(withTitles: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.list)
        nameErrorInfoBubble.image = InfoBubble.imageOfInfo_bubble
        popupBox2InfoBubble.image = InfoBubble.imageOfInfo_bubble
        popupBox4InfoBubble.image = InfoBubble.imageOfInfo_bubble
        additionalPolicyMessageInfoBubble.image = InfoBubble.imageOfInfo_bubble
    }
    
    private func setTextFields() {
        welcomeMessage.textColor = .headerTextColor
        additionalPolicyMessage.set(label: PrimaryRegistrationChildVC_Constants.additionalPolicyMessage, color: .controlTextColor)
        let controlTextFields = [nameErrorMessage, popupButton1Header, popupButton2Header, popupButton3Header, popupButton4Header]
        for i in controlTextFields {
            i?.textColor = .controlTextColor
        }
    }
    
    
    /**
     Function for configuring the primary welcome message and popup button state
     
     Note: the `hrFirstName` is stored on enrollment trigger with an API request to the JPS prior to app launch
    */
    private func loadConfigurationStateFromPlist() {
        if let hrFirstName = UserDefaults.standard.string(forKey: PrimaryRegistrationChildVC_Constants.Keys.hrFirstName) {
            welcomeMessage.stringValue = "Welcome, \(hrFirstName.capitalized)"
            nameErrorMessage.stringValue = "Not \(hrFirstName.capitalized)?"
        }
        validatePercentageCompletion()
    }
    
    /**
     Function for validating the percentage of completion for selecting options for every popup button based on stored values.
     - Parameter aPopupChoice: Popup button choice made by user
     - Parameter key: Propertylist key for reading / storing the choice made by the user
     - Parameter popup: Popup button for displaying and allowing for choices
     - Parameter returnCodes: Return codes associated with user facing choices
     - Parameter percentageCompleteIndex: Index value is either on or off (1 or 0)
    */
    private func validatePopUpBoxChoice(aPopupChoice: String, key: String, popup: NSPopUpButton!, returnCodes: [String], percentageCompleteIndex: Int) {
        if let aPopupChoice = UserDefaults.standard.string(forKey: key) {
            popup.selectItem(at: (returnCodes.index(of: aPopupChoice))!)
            if UserDefaults.standard.string(forKey: key) != nil && UserDefaults.standard.string(forKey: key) != "" { self.percentageOfCompletion[percentageCompleteIndex] = 1}
        }
    }
    
    /**
     Function for updating the UI based on the choices selected.
     - Parameter aPopupChoice: Popup button choice made by user
     - Parameter key: Propertylist key for reading / storing the choice made by the user
     - Parameter popup: Popup button for displaying and allowing for choices
     - Parameter returnCodes: Return codes associated with user facing choices
     - Parameter percentageCompleteIndex: Index value is either on or off (1 or 0)
     */
    private func updateUIFromSelection(aPopupChoice: String, key: String, popup: NSPopUpButton!, returnCodes: [String], perentageCompleteIndex: Int) {
        let aPopupChoice = popup.indexOfSelectedItem
        if aPopupChoice > 0 {
            percentageOfCompletion[perentageCompleteIndex] = 1
        } else {
            percentageOfCompletion[perentageCompleteIndex] = 0
        }
        UserDefaults.standard.set(returnCodes[aPopupChoice], forKey: key)
        UserDefaults.standard.synchronize()
        setStateForContinueToNextStepButton()
    }
    
    private func validatePercentageCompletion() {
        validatePopUpBoxChoice(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.selectedType,
                               key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.key,
                               popup: popupButton1,
                               returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.codes,
                               percentageCompleteIndex: 0)
        validatePopUpBoxChoice(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.selectedType,
                               key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.key,
                               popup: popupButton2,
                               returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.codes,
                               percentageCompleteIndex: 1)
        validatePopUpBoxChoice(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.selectedType,
                               key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.key,
                               popup: popupButton3,
                               returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.codes,
                               percentageCompleteIndex: 2)
        validatePopUpBoxChoice(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.selectedType,
                               key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.key,
                               popup: popupButton4,
                               returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.codes,
                               percentageCompleteIndex: 3)
        
        setStateForContinueToNextStepButton()
    }
    
    private func setStateForContinueToNextStepButton() {
        continueToNextStepButton.fadeTransition(0.25)
        if percentageOfCompletion.contains(0) {
            continueToNextStepButton.isEnabled = false
        } else {
            continueToNextStepButton.isEnabled = true
        }
    }
    
    // Popup Boxes
    @IBAction func popupButton1Clicked(_ sender: NSPopUpButton) {
        updateUIFromSelection(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.selectedType,
                              key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.key,
                              popup: popupButton1,
                              returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info1.codes,
                              perentageCompleteIndex: 0)
    }
    
    @IBAction func popupButton2Clicked(_ sender: NSPopUpButton) {
        updateUIFromSelection(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.selectedType,
                              key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.key,
                              popup: popupButton2,
                              returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info2.codes,
                              perentageCompleteIndex: 1)
    }
    
    @IBAction func popupButton3Clicked(_ sender: NSPopUpButton) {
        updateUIFromSelection(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.selectedType,
                              key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.key,
                              popup: popupButton3,
                              returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info3.codes,
                              perentageCompleteIndex: 2)
    }
    
    @IBAction func popupButton4Clicked(_ sender: NSPopUpButton) {
        updateUIFromSelection(aPopupChoice: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.selectedType,
                              key: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.key,
                              popup: popupButton4,
                              returnCodes: PrimaryRegistrationChildVC_Constants.PopupButtons.PopupBoxes.Info4.codes,
                              perentageCompleteIndex: 3)
    }
    
    
    // Info Bubble Popovers
    @IBAction func info2PopoverButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.PrimaryRegisrationChildViewController.info2, sender: self)
    }
    
    @IBAction func info4PopoverButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.PrimaryRegisrationChildViewController.info4, sender: self)
    }
    
    @IBAction func infoSecurityDescriptionsPopoverButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.PrimaryRegisrationChildViewController.securityDescription, sender: self)
    }
    
    // Transition Buttons
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        IssueAlertService.sharedInstance.displaySheetWithJAMFAction(header: AlertText.RegistrationCancelAlert.header,
                                           message: AlertText.RegistrationCancelAlert.message,
                                           style: .critical,
                                           cancelButtonLabel: UserInteractionButtons.no,
                                           actionButtonLabel: UserInteractionButtons.yes,
                                           jamfPolicyEvent: JAMFPolicyEventID.removeFramework,
                                           button1LogText: UserInteractionButtons.InteractionLogText.removeFrameworkCancelledLog)
    }
    
    @IBAction func continueToSecondaryRegistration(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.ForwardTo.secondaryRegistrationChildViewController, sender: self)
    }
}
