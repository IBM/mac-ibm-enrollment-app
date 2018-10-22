//
//  RegistrationCompleteChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/2/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

protocol RegistrationCompleteChildViewControllerDelegate: class {
    func registrationCompleteChildViewControllerWillRestart(_ viewController: RegistrationCompleteChildViewController)
}

class RegistrationCompleteChildViewController: NSViewController {

    @IBOutlet weak var headerTextLabel: NSTextField!
    @IBOutlet weak var subheaderTextLabel: NSTextField!
    @IBOutlet weak var countdownMessageLabel: NSTextField!
    @IBOutlet weak var instructionalMessageLabel: NSTextField!
    
    weak var delegate: RegistrationCompleteChildViewController?
    var count = RegistrationCompleteChildVC_Constants.initialCountdownValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
    }
    
    private func layoutSetup() {
        var _ = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { (Timer) in
            self.updateCounter()
        }
    }
    
    private func setTextFields() {
        headerTextLabel.set(label: RegistrationCompleteChildVC_Constants.header, color: .headerTextColor)
        subheaderTextLabel.set(label: RegistrationCompleteChildVC_Constants.subheader, color: .controlTextColor)
        countdownMessageLabel.set(label: RegistrationCompleteChildVC_Constants.countdownMessage, color: .controlTextColor)
        instructionalMessageLabel.set(label: RegistrationCompleteChildVC_Constants.instructionalMessage, color: .controlTextColor)
    }
    
    private func restartComputer() {
        var systemProcessPSN = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kSystemProcess))
        let systemProcessDescriptor = NSAppleEventDescriptor(descriptorType: DescType(typeProcessSerialNumber),
                                                             bytes: &systemProcessPSN,
                                                             length: MemoryLayout.size(ofValue: systemProcessPSN))
        let rebootEvent = NSAppleEventDescriptor(eventClass: AEEventClass(kCoreEventClass),
                                                 eventID: AEEventID(kAERestart),
                                                 targetDescriptor: systemProcessDescriptor,
                                                 returnID: AEReturnID(kAutoGenerateReturnID),
                                                 transactionID: AETransactionID(kAnyTransactionID))
        let err = AESendMessage(rebootEvent.aeDesc, nil, AESendMode(kAENoReply), kAEDefaultTimeout)
        if (err != noErr) {
            let failureAlert = NSAlert()
            failureAlert.messageText = NSLocalizedString(RegistrationCompleteChildVC_Constants.FailureToRestart.message, comment: RegistrationCompleteChildVC_Constants.FailureToRestart.comment)
            failureAlert.runModal()
        }
    }
    
    private func updateCounter() {
        if (count >= 1) {
            countdownMessageLabel.stringValue = "Your Mac will be restarted automatically in \(count) minutes to continue the setup process."
            count -= 1
        } else {
            UserDefaults.standard.set("1", forKey: StartingPointID.UserDefaultsKey.phase)
            self.restartComputer()
        }
    }
    
    
    @IBAction func restartButtonClicked(_ sender: NSButton) {
        UserDefaults.standard.set("1", forKey: StartingPointID.UserDefaultsKey.phase)
        UserDefaults.standard.synchronize()
        self.restartComputer()
    }
}
