//
//  AnimatedGIFProgressViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/1/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class AnimatedGIFProgressViewController: NSViewController {
    
    @IBOutlet weak var animatedGIFView: NSImageView!
    @IBOutlet weak var progressAlertTextLabel: NSTextField!
    
    var progressCounter = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressAlertTextLabel.stringValue = AnimatedGIFProgressChildVC_Constants.RegistrationProgress.stateOne
        loadAnimatedGIF()
        setTextFields()
        var _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            self.updateProgressCounter()
        }
    }
    
    private func setTextFields() {
        progressAlertTextLabel.textColor = .headerTextColor
    }
    
    private func loadAnimatedGIF() {
        let animatedGIF = animatedGIFView
        animatedGIF?.canDrawSubviewsIntoLayer = true
        animatedGIF?.imageScaling = .scaleProportionallyUpOrDown
        animatedGIF?.animates = true
        animatedGIF?.image = NSImage(named: AnimatedGIFProgressChildVC_Constants.AnimatedProgressGIF.fileName)
        self.view.addSubview(animatedGIF!)
    }
    
    private func updateProgressCounter() {
        if (progressCounter >= 0) {
            progressCounter = progressCounter - 1
        }
        switch progressCounter {
        case 2...10 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.stringValue = AnimatedGIFProgressChildVC_Constants.RegistrationProgress.stateTwo
        case 11...20 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.stringValue = AnimatedGIFProgressChildVC_Constants.RegistrationProgress.stateOne
        case 1 :
            progressAlertTextLabel.fadeTransition(0.10)
            progressAlertTextLabel.isHidden = true
        case 0 :
            self.performSegue(withIdentifier: SegueDestinationID.ForwardTo.registrationCompleteChildViewControllter, sender: self)
        default:
            break
        }
    }
}
