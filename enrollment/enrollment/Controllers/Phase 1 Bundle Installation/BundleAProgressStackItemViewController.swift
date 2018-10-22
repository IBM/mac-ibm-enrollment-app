//
//  BundleAProgressStackItemViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/28/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

class BundleAProgressStackItemViewController: BaseViewController {

    @IBOutlet weak var progressIndicatorApp1: CircularStatus!
    
    @IBOutlet weak var app1NameTextLabel: NSTextField!
    
    private var anchorStopApp1 = 0
    private var anchorStopHeader = 0
    
    private var totalBundleResult: Array<Double> = [Double](repeating: 0.0, count: AppBundles.Bundle.A.Infopopover.titles.count)
    
    override func headerTitle() -> String {
        return NSLocalizedString(AppBundles.Bundle.A.Infopopover.header.capitalized, comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicatorApp1.state = .appInQueue
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
    }
    
    private func setTextFields() {
        app1NameTextLabel.set(label: AppBundles.Bundle.A.Infopopover.titles[0], color: .controlTextColor)
    }
    
    private func updateUI() {
        _ = UpdateUIForAppStatus(appStatusKey: AppBundles.Bundle.A.Keys.Bundle.AppStatus.app1,
                                  appIndicator: progressIndicatorApp1,
                                  anchorStop: &anchorStopApp1,
                                  totalBundleResult: &totalBundleResult,
                                  index: 0)
    
        if let valueConnectivityBundleMessaging = UserDefaults.standard.value(forKey: AppBundles.Bundle.A.Keys.Bundle.messaging) {
            let headerVC = self.stackItemContainer?.header as! HeaderViewController
            headerVC.updateWithProgressMessage(statusText: valueConnectivityBundleMessaging as! String)
        }
        
        if let valueConnectivityBundleIndicator = UserDefaults.standard.value(forKey: AppBundles.Bundle.A.Keys.Bundle.status) {
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
