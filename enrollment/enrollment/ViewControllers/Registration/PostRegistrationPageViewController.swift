//
//  PostRegistrationPageViewController.swift
//  enrollment
//
//  Created by Simone Martorelli on 4/5/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the last page of the registration process.
class PostRegistrationPageViewController: NSViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleInfoLabel: InfoLabelView!
    @IBOutlet weak var subTitleInfoLabel: InfoLabelView!
    @IBOutlet weak var countdownLabel: NSTextField!
    @IBOutlet weak var bodyLabel: NSTextField!
    @IBOutlet weak var footerMessageInfoLabel: InfoLabelView!
    @IBOutlet weak var restartCloseButton: NSButton!
    @IBOutlet weak var updateInfoButton: NSButton!
    
    // MARK: - Variables
    
    static let controllerID = "PostRegistrationPageViewController"
    private var countdown = Context.main?.dataSet.postRegistrationPage.restartTimeout ?? 300
    private var isRegistrationOnlyPhase: Bool {
        return Context.main?.dataSet.phase == "3"
    }
    private var isInstallationOnlyPhase: Bool {
        return Context.main?.dataSet.phase == "4"
    }
    private var restartNeeded: Bool {
        return Context.main?.dataSet.bundleInstallationPage?.bundleInstallationNeedsRestartBefore ?? true
    }
    private var timer: Timer?
    private var postRegistrationPageData: PostRegistrationPage = (Context.main?.dataSet.postRegistrationPage)!
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTimer()
        configureUIElements()
        updateRegistrationStatus()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private methods
    
    private func configureTimer() {
        guard restartNeeded else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateCounter()
        }
    }
    
    private func configureUIElements() {
        self.titleInfoLabel.labelledInfo = postRegistrationPageData.title
        titleInfoLabel.font = .systemFont(ofSize: 28)
        if let infos = titleInfoLabel.labelledInfo?.infoSection {
            titleInfoLabel.onInfoButtonPressed = { view in
                self.didPressedInfoButton(view, infos: infos)
            }
        }
        if let subtitle = postRegistrationPageData.subtitle {
            self.subTitleInfoLabel.labelledInfo = subtitle
            if let infos = subTitleInfoLabel.labelledInfo?.infoSection {
                subTitleInfoLabel.onInfoButtonPressed = { view in
                    self.didPressedInfoButton(view, infos: infos)
                }
            }
        } else {
            self.subTitleInfoLabel.isHidden = true
        }
        if let footer = postRegistrationPageData.footer {
            self.footerMessageInfoLabel.labelledInfo = footer
            if let infos = footerMessageInfoLabel.labelledInfo?.infoSection {
                footerMessageInfoLabel.onInfoButtonPressed = { view in
                    self.didPressedInfoButton(view, infos: infos)
                }
            }
        } else {
            self.footerMessageInfoLabel.isHidden = true
        }
        if isRegistrationOnlyPhase {
            self.bodyLabel.attributedStringValue = self.getSelectedInfo()
        } else {
            self.bodyLabel.set(label: postRegistrationPageData.body.localized, color: .controlTextColor)
        }
        if restartNeeded {
            restartCloseButton.title = "buttonLabelRestart".localized
            countdownLabel.set(label: String(format: "postRegistrationPageCountdownMessage".localized, countdown), color: .controlTextColor)
        } else if isRegistrationOnlyPhase {
            restartCloseButton.title = "buttonLabelClose".localized
        } else {
            restartCloseButton.title = "buttonLabelNext".localized
        }
    }
    
    private func updateRegistrationStatus() {
        Context.main?.dataSet.registration?.registrationStatus = true
    }
    
    private func restartComputer() {
        if isRegistrationOnlyPhase {
            Context.main?.dataSet.phase = "2"
        } else {
            Context.main?.dataSet.phase = "1"
        }
        
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
        if err != noErr {
            let failureAlert = NSAlert()
            failureAlert.messageText = NSLocalizedString("restartFailureMessage".localized, comment: "restartFailureComment".localized)
            failureAlert.runModal()
        }
    }
    
    private func updateCounter() {
        if countdown >= 1 {
            countdownLabel.stringValue = String(format: "postRegistrationPageCountdownMessage".localized, countdown)
            countdown -= 1
        } else {
            self.restartComputer()
        }
    }
    
    /// This method get the registration info selected by the user and build up an attributed string with the follow row "schema":
    /// <bold>"FieldTitle"</bold>: "selected option"
    /// - Returns: attributed string.
    private func getSelectedInfo() -> NSMutableAttributedString {
        guard let selectedRegistrationInfo = Context.main?.dataSet.selectedRegistrationInfo else {
            return NSMutableAttributedString()
        }
        
        let composedString = NSMutableAttributedString()
        for info in selectedRegistrationInfo {
            let infoString = NSMutableAttributedString(string: info.fieldTitle.localized, attributes: [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 13)])
            if info.isMultipleChoiseAllowed {
                infoString.append(NSAttributedString(string: ": "))
                for (index, title) in info.selectedOptionTitles.enumerated() {
                    infoString.append(NSAttributedString(string: title.localized))
                    if index < (info.selectedOptionTitles.count - 1) {
                        infoString.append(NSAttributedString(string: ", "))
                    }
                }
                infoString.append(NSAttributedString(string: "\n\n"))
            } else {
                infoString.append(NSAttributedString(string: ": " + (info.selectedOptionTitles.first?.localized ?? "") + "\n\n"))
            }
            composedString.append(infoString)
        }
        composedString.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.controlTextColor], range: NSRange(location: 0, length: composedString.string.utf16.count))
        return composedString
    }
    
    // MARK: - Actions
    
    @IBAction func didPressBottomRightButton(_ sender: NSButton) {
        if isRegistrationOnlyPhase {
            NSApplication.shared.terminate(self)
        } else if isInstallationOnlyPhase && restartNeeded {
            self.restartComputer()
        } else if restartNeeded {
            self.restartComputer()
        } else {
            self.performSegue(withIdentifier: "goToInstallationPhase", sender: self)
        }
    }
    
    @IBAction func didPressBottomLeftButton(_ sender: NSButton) {
        if isRegistrationOnlyPhase {
            self.performSegue(withIdentifier: "goToFirstRegistrationPage", sender: nil)
        } else if isInstallationOnlyPhase {
            IssueAlertService.sharedInstance.displaySheetWithJAMFAction(header: AlertText.RegistrationCancelAlert.header,
                                                                        message: AlertText.RegistrationCancelAlert.message,
                                                                        style: .critical,
                                                                        cancelButtonLabel: "labelNo".localized,
                                                                        actionButtonLabel: "labelYes".localized,
                                                                        jamfPolicyEvent: Context.main?.dataSet.policies.removeFramework ?? "",
                                                                        button1LogText: "unenrollmentCancelled".localized)
        }
    }
    
    func didPressedInfoButton(_ sender: NSButton, infos: InfoSection) {
        let infoPopupViewController = InfoPopOverViewController(with: infos)
        self.present(infoPopupViewController, asPopoverRelativeTo: sender.convert(sender.bounds, to: self.view), of: self.view, preferredEdge: .maxX, behavior: .semitransient)
    }
}
