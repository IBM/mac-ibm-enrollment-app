//
//  BundleInstallationChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 9/2/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class BundleInstallationChildViewController: NSViewController, StackItemHost {

    @IBOutlet weak var headerMessageTextLabel: NSTextField!
    @IBOutlet weak var errorMessageTextLabel: NSTextField!
    @IBOutlet weak var estimatedTimeRemainingMessageTextLabel: NSTextField!
    @IBOutlet weak var estimatedTimeRemainingLabel: NSTextField!
    @IBOutlet weak var bundleStack: CustomStackView!
    
    @IBOutlet weak var nextButton: NSButton!
    
    var installClock = Double()
    var myContext = 0
    
    var installProgress: Progress? {
        willSet {
            guard let oldProgress = installProgress else { return }
            oldProgress.removeObserver(self,
                                       forKeyPath: AppBundles.Keys.AppInstallScreen.status,
                                       context: &myContext)
        }
        didSet {
            guard let newProgress = installProgress else { return }
            newProgress.addObserver(self,
                                    forKeyPath: AppBundles.Keys.AppInstallScreen.status,
                                    options: .new,
                                    context: &myContext)
        }
    }
    
    deinit {
        installProgress?.removeObserver(self,
                                        forKeyPath: AppBundles.Keys.AppInstallScreen.status,
                                        context: &myContext)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInstallTimeClockFromBundleSelectionController()
        addObservers()
        layoutSetup()
        setTextFields()
        XPCService.sharedInstance.processJAMFAction(event: JAMFPolicyEventID.softwareInstall)
        var _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            self.updateCounter()
        }
    }
    
    private func setTextFields() {
        headerMessageTextLabel.set(label: BundleSelectionChildVC_Constants.header, color: .headerTextColor)
        errorMessageTextLabel.set(label: AlertText.BundleInstallationWarning.message, color: .controlTextColor)
        estimatedTimeRemainingMessageTextLabel.textColor = .headerTextColor
        estimatedTimeRemainingLabel.textColor = .headerTextColor
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == AppBundles.Keys.AppInstallScreen.status {
            if context == &myContext {
                if UserDefaults.standard.integer(forKey: AppBundles.Keys.AppInstallScreen.warning) == 1 {
                    errorMessageTextLabel.fadeTransition(0.25)
                    errorMessageTextLabel.isHidden = false
                }
                enableUIForAdvancementToNextScreen()
            }
            DispatchQueue.main.async {
                self.view.needsDisplay = true
            }
        }
    }
    
    private func createInstallTimeClockFromBundleSelectionController() {
        if UserDefaults.standard.string(forKey: AppBundles.Keys.installClockTotal) != nil {
            let clockStartTimeInSeconds = Double(UserDefaults.standard.string(forKey: AppBundles.Keys.installClockTotal)!)
            estimatedTimeRemainingLabel.stringValue = clockFormatter(totalTimeInSeconds: clockStartTimeInSeconds!)
            installClock = clockStartTimeInSeconds!
        }
    }
    
    private func layoutSetup() {
        bundleStack.setHuggingPriority(NSLayoutConstraint.Priority.defaultHigh, for: .horizontal)
        var bundleChoiceArray = [String]()
        
        if let bundleChoiceSelection = (UserDefaults.standard.array(forKey: AppBundles.Keys.bundleArrayKey)!) as? [String] {
            for bundleChoice in bundleChoiceSelection {
                bundleChoiceArray.append(bundleChoice)
            }
        }
        
        if bundleChoiceArray.contains(AppBundles.PersistanceArrayMember.a) {
            addViewController(withIdentifier: "BundleAProgressStackItemViewController")
        }
        if bundleChoiceArray.contains(AppBundles.PersistanceArrayMember.b) {
            addViewController(withIdentifier: "BundleBProgressStackItemViewController")
        }
        if bundleChoiceArray.contains(AppBundles.PersistanceArrayMember.c) {
            addViewController(withIdentifier: "BundleCProgressStackItemViewController")
        }
    }
    
    private func addViewController(withIdentifier identifier: String) {
        let storyboard = NSStoryboard(name: "StackItems", bundle: nil)
        let viewController = storyboard.instantiateController(withIdentifier: identifier) as! BaseViewController
        
        let stackItem = viewController.stackItemContainer!
        stackItem.header.disclose = {
            self.disclose(viewController.stackItemContainer!)
        }
        
        bundleStack.addArrangedSubview(stackItem.header.viewController.view)
        bundleStack.addArrangedSubview(stackItem.body.viewController.view)
        
        addChild(stackItem.body.viewController)
        addChild(stackItem.header.viewController)
        
        switch stackItem.state {
        case .open: show(stackItem, animated: false)
        case .closed: hide(stackItem, animated: false)
        }
    }
    
    private func enableUIForAdvancementToNextScreen() {
        estimatedTimeRemainingMessageTextLabel.fadeTransition(0.25)
        estimatedTimeRemainingLabel.fadeTransition(0.25)
        nextButton.fadeTransition(0.25)
        nextButton.isEnabled = true
        estimatedTimeRemainingMessageTextLabel.isHidden = true
        estimatedTimeRemainingLabel.isHidden = true
    }
    
    private func addObservers() {
        UserDefaults.standard.addObserver(self, forKeyPath: AppBundles.Keys.AppInstallScreen.status, options: .new, context: &myContext)
    }
    
    private func updateCounter() {
        if (installClock > 0) {
            estimatedTimeRemainingLabel.stringValue = clockFormatter(totalTimeInSeconds: installClock)
            installClock -= 1
            self.view.needsDisplay = true
        }
    }
    
    private func clockFormatter(totalTimeInSeconds: Double) -> String {
        
        let duration: TimeInterval = Double(totalTimeInSeconds)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDuration = formatter.string(from: duration)
        return formattedDuration!
    }
    
    @IBAction func nextButtonClicked(_ sender: NSButton) {
        UserDefaults.standard.set("2", forKey: StartingPointID.UserDefaultsKey.phase)
        performSegue(withIdentifier: SegueDestinationID.ForwardTo.setupCompleteChildViewController, sender: self)
    }
}

class CustomStackView: NSStackView {
    override var isFlipped: Bool { return true }
}
