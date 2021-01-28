//
//  AnimatedGIFProgressViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/1/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the registration loading page.
class AnimatedGIFProgressViewController: NSViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var animatedGIFView: NSImageView!
    @IBOutlet weak var progressAlertTextLabel: NSTextField!
    
    // MAKR: - Variables
    
    var progressCounter: Int!
    var timer: Timer?
    private var isRegistrationOnlyPhase: Bool {
        return Context.main?.dataSet.phase == "3"
    }
    
    // MARK: - Instance methods
    
    override func viewWillAppear() {
        super.viewWillAppear()
        configureGIFView()
        configureLabels()
        configureTimer()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        PrivilegedHelperController.shared.processJAMFPolicy(Context.main?.dataSet.policies.registrationPolicy ?? "")
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private methods
    
    private func configureTimer() {
        progressCounter = isRegistrationOnlyPhase ? 10 : 20
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateProgressCounter()
        }
    }
    
    private func configureLabels() {
        progressAlertTextLabel.stringValue = isRegistrationOnlyPhase ? "registrationLoadingPageStateForPhaseThree".localized : "registrationLoadingPageStateOne".localized
        progressAlertTextLabel.textColor = .headerTextColor
    }
    
    private func configureGIFView() {
        animatedGIFView.canDrawSubviewsIntoLayer = true
        animatedGIFView.imageScaling = .scaleProportionallyUpOrDown
        if currentInterfaceStyle() == .light {
            animatedGIFView.image = NSImage(named: "bee-blue.gif")
        } else {
            animatedGIFView.image = NSImage(named: "bee-lowlight.gif")
        }
        animatedGIFView.animates = true
    }
    
    /// This method called by the timer implement a fake loading.
    private func updateProgressCounter() {
        if progressCounter >= 0 {
            progressCounter -= 1
        }
        switch progressCounter! {
        case 2...10 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.stringValue = isRegistrationOnlyPhase ? "registrationLoadingPageStateForPhaseThree".localized : "registrationLoadingPageStateTwo".localized
        case 11...20 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.stringValue = "registrationLoadingPageStateOne".localized
        case 1 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.isHidden = true
        case 0 :
            self.performSegue(withIdentifier: "goToPostRegistrationPage", sender: self)
        default:
            break
        }
    }
}
