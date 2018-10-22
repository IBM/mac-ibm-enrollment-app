//
//  BundleBProgressStackItemViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/28/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class BundleBProgressStackItemViewController: BaseViewController {
    
    @IBOutlet weak var progressIndicatorApp1: CircularStatus!
    @IBOutlet weak var progressIndicatorApp2: CircularStatus!
    @IBOutlet weak var progressIndicatorApp3: CircularStatus!
    @IBOutlet weak var progressIndicatorApp4: CircularStatus!
    
    @IBOutlet weak var app1NameTextLabel: NSTextField!
    @IBOutlet weak var app2NameTextLabel: NSTextField!
    @IBOutlet weak var app3NameTextLabel: NSTextField!
    @IBOutlet weak var app4NameTextLabel: NSTextField!
    
    private var anchorStopApp1 = 0
    private var anchorStopApp2 = 0
    private var anchorStopApp3 = 0
    private var anchorStopApp4 = 0
    private var anchorStopHeader = 0
    
    private var totalBundleResult: Array<Double> = [Double](repeating: 0.0, count: AppBundles.Bundle.B.InfoPopover.titles.count)
    
    override func headerTitle() -> String {
        return NSLocalizedString(AppBundles.Bundle.B.InfoPopover.header.capitalized, comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicatorApp1.state = .appInQueue
        progressIndicatorApp2.state = .appInQueue
        progressIndicatorApp3.state = .appInQueue
        progressIndicatorApp4.state = .appInQueue
        var _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (Timer) in
            self.updateUI()
        }
    }
    
    override func viewWillLayout() {
        layoutSetup()
        setTextFields()
    }
    
    private func layoutSetup() {
        progressIndicatorApp1.fadeTransition(2.0)
        progressIndicatorApp2.fadeTransition(2.0)
        progressIndicatorApp3.fadeTransition(2.0)
        progressIndicatorApp4.fadeTransition(2.0)
    }
    
    private func setTextFields() {
        app1NameTextLabel.set(label: AppBundles.Bundle.B.InfoPopover.titles[0], color: .controlTextColor)
        app2NameTextLabel.set(label: AppBundles.Bundle.B.InfoPopover.titles[1], color: .controlTextColor)
        app3NameTextLabel.set(label: AppBundles.Bundle.B.InfoPopover.titles[2], color: .controlTextColor)
        app4NameTextLabel.set(label: AppBundles.Bundle.B.InfoPopover.titles[3], color: .controlTextColor)
    }
    
    
    private func updateUI() {
        _ = UpdateUIForAppStatus(appStatusKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app1,
                                 appIndicator: progressIndicatorApp1,
                                 anchorStop: &anchorStopApp1,
                                 totalBundleResult: &totalBundleResult,
                                 index: 0)
        _ = UpdateUIForAppStatus(appStatusKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app2,
                                 appIndicator: progressIndicatorApp2,
                                 anchorStop: &anchorStopApp2,
                                 totalBundleResult: &totalBundleResult,
                                 index: 1)
        _ = UpdateUIForAppStatus(appStatusKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app3,
                                 appIndicator: progressIndicatorApp3,
                                 anchorStop: &anchorStopApp3,
                                 totalBundleResult: &totalBundleResult,
                                 index: 2)
        _ = UpdateUIForAppStatus(appStatusKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app4,
                                 appIndicator: progressIndicatorApp4,
                                 anchorStop: &anchorStopApp4,
                                 totalBundleResult: &totalBundleResult,
                                 index: 3)
        
        if let valueConnectivityBundleMessaging = UserDefaults.standard.value(forKey: AppBundles.Bundle.B.Keys.Bundle.messaging) {
            let headerVC = self.stackItemContainer?.header as! HeaderViewController
            headerVC.updateWithProgressMessage(statusText: valueConnectivityBundleMessaging as! String)
        }
        
        if let valueConnectivityBundleIndicator = UserDefaults.standard.value(forKey: AppBundles.Bundle.B.Keys.Bundle.status) {
            let headerVC = self.stackItemContainer?.header as! HeaderViewController
            switch String(describing: valueConnectivityBundleIndicator) {
            case "0" :
                headerVC.updateWithProgressIndicator(progressIndicator: .inQueue)
            case "1" :
                headerVC.updateWithProgressIndicator(progressIndicator: .inProgressAnimated)
                if anchorStopHeader == 0 {
                    headerVC.bundleProgressIndicator.determineAnchorPoint(indicator: headerVC.bundleProgressIndicator)
                }
                anchorStopHeader = 1
                headerVC.bundleProgressIndicator.rotate()
            case "2" :
                headerVC.bundleProgressIndicator.stopRotation()
                let sumArray = totalBundleResult.reduce(0, +)
                let avgArrayValue = sumArray / Double(totalBundleResult.count)
                if avgArrayValue == 1.0 {
                    headerVC.updateWithProgressIndicator(progressIndicator: .success)
                }
                else if avgArrayValue == 0.0 {
                    headerVC.updateWithProgressIndicator(progressIndicator: .failure)
                    UserDefaults.standard.set(1, forKey: AppBundles.Bundle.AppInstallScreen.warning)
                }
                else {
                    headerVC.updateWithProgressIndicator(progressIndicator: .partial)
                    UserDefaults.standard.set(1, forKey: AppBundles.Bundle.AppInstallScreen.warning)
                }
            default:
                return
            }
            UserDefaults.standard.synchronize()
        }
    }
}
