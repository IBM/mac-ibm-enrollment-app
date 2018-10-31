//
//  BundleSelectionChildViewController.swift
//  enrollment
//
//  Created by Jay Latman on 8/2/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

class BundleSelectionChildViewController: NSViewController {
    
    @IBOutlet weak var headerMessageTextLabel: NSTextField!
    @IBOutlet weak var subheaderMessageTextLabel: NSTextField!
    @IBOutlet weak var recommendedLabel: NSTextField!
    
    @IBOutlet weak var aToggle: NSButton!
    @IBOutlet weak var bToggle: NSButton!
    @IBOutlet weak var cToggle: NSButton!
    
    @IBOutlet weak var aToggleDescription: NSTextField!
    @IBOutlet weak var bToggleDescription: NSTextField!
    @IBOutlet weak var cToggleDescription: NSTextField!
    
    @IBOutlet weak var aDownloadTimeLabel: NSTextField!
    @IBOutlet weak var bDownloadTimeLabel: NSTextField!
    @IBOutlet weak var cDownloadTimeLabel: NSTextField!
    @IBOutlet weak var totalDownloadTimeLabel: NSTextField!
    
    
    @IBOutlet weak var essentialsInfoButton: NSButton!
    @IBOutlet weak var productivityInfoButton: NSButton!
    @IBOutlet weak var installSelectedBundlesButton: NSButton!
    @IBOutlet weak var skipButton: NSButton!
    
    var returnCode = String()
    var jpsCheckResult = Int()
    var jpsHealthCheckServiceURL: String = JPSPaths.HealthCheckURLs.Prod.healthCheckURL
    
    var totalInstallTime = [Double](repeating: 0.0, count: 3)
    var totalBundleSize = [Double](repeating: 0.0, count: 3)
    
    let cancelHeader: String = AlertText.BundleSelectionWarning.header
    let cancelMessage: String = AlertText.BundleSelectionWarning.message
    
    private var bundleToggleButtons: [NSButton]!
    
    var bundleChoiceSelected: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setTextFields()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        bundleToggleButtons = [aToggle, bToggle, cToggle]
    }
    
    private func layoutSetup() {
        aToggle.set(toggleLabel: " " + BundleSelectionChildVC_Constants.Toggle.Title.a, underline: 0)
        bToggle.set(toggleLabel: " " + BundleSelectionChildVC_Constants.Toggle.Title.b, underline: 0)
        cToggle.set(toggleLabel: " " + BundleSelectionChildVC_Constants.Toggle.Title.c, underline: 0)
        essentialsInfoButton.image = InfoBubble.imageOfInfo_bubble
        productivityInfoButton.image = InfoBubble.imageOfInfo_bubble
        setKeysToFactoryDefaults()
        checkForEmptyChoiceArrayAndSetButtonDisplay()
        displayIndividualDownloadTimes()
        
        if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
            let totalDownloadTime = displayTotalDownloadtime(speedTestRate: Double(speedTestResult)!)
            totalDownloadTimeLabel.stringValue = "+ \(totalDownloadTime)"
        }
    }
    
    private func setTextFields() {
        headerMessageTextLabel.set(label: BundleSelectionChildVC_Constants.header, color: .headerTextColor)
        subheaderMessageTextLabel.set(label: BundleSelectionChildVC_Constants.subheader, color: .controlTextColor)
        recommendedLabel.set(label: BundleSelectionChildVC_Constants.recommend_label, color: .systemRed)
        aToggleDescription.set(label: BundleSelectionChildVC_Constants.Toggle.Description.a, color: .controlTextColor)
        bToggleDescription.set(label: BundleSelectionChildVC_Constants.Toggle.Description.b, color: .controlTextColor)
        cToggleDescription.set(label: BundleSelectionChildVC_Constants.Toggle.Description.c, color: .controlTextColor)
        totalDownloadTimeLabel.textColor = .headerTextColor
        let controlTextFields = [aDownloadTimeLabel, bDownloadTimeLabel, cDownloadTimeLabel]
        for i in controlTextFields {
            i?.textColor = .controlTextColor
        }
    }
    
    private func setKeysToFactoryDefaults() {
        UserDefaults.standard.set(false, forKey: AppBundles.Bundle.AppInstallScreen.status)
        UserDefaults.standard.set(false, forKey: AppBundles.Bundle.AppInstallScreen.warning)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.A.Keys.Bundle.status)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.B.Keys.Bundle.status)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.C.Keys.Bundle.status)
        UserDefaults.standard.set("", forKey: AppBundles.Bundle.A.Keys.Bundle.messaging)
        UserDefaults.standard.set("", forKey: AppBundles.Bundle.B.Keys.Bundle.messaging)
        UserDefaults.standard.set("", forKey: AppBundles.Bundle.C.Keys.Bundle.messaging)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.A.Keys.Bundle.AppStatus.app1)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app1)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app2)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app3)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.B.Keys.Bundle.AppStatus.app4)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.C.Keys.Bundle.AppStatus.app1)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.C.Keys.Bundle.AppStatus.app2)
        UserDefaults.standard.set(0, forKey: AppBundles.Bundle.C.Keys.Bundle.AppStatus.app3)
        UserDefaults.standard.set(Array(bundleChoiceSelected), forKey: AppBundles.bundleArrayKey)
        UserDefaults.standard.synchronize()
    }
    
    private func checkForEmptyChoiceArrayAndSetButtonDisplay() {
        if let bundleArray = UserDefaults.standard.array(forKey: AppBundles.bundleArrayKey) {
            skipButton.fadeTransition(0.25)
            installSelectedBundlesButton.fadeTransition(0.25)
            if (bundleArray.count ) > 0 {
                BundleInstallButtonVisibility.displayButtons(label: totalDownloadTimeLabel,
                                                             labelState: false,
                                                             installButton: installSelectedBundlesButton,
                                                             installButtonState: false,
                                                             skipButton: skipButton,
                                                             skipButtonState: true)
            } else {
                BundleInstallButtonVisibility.displayButtons(label: totalDownloadTimeLabel,
                                                             labelState: true,
                                                             installButton: installSelectedBundlesButton,
                                                             installButtonState: true,
                                                             skipButton: skipButton, skipButtonState: false)
            }
        }
    }
    
    private func timeForDownload(speedTestRate: Double, bundleSize: Double, bundleInstallTimeInSeconds: Double, jamfComBufferTimeInSeconds: Double) -> String {
        
        let duration: TimeInterval = ((bundleSize / speedTestRate) + bundleInstallTimeInSeconds + jamfComBufferTimeInSeconds)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDuration = formatter.string(from: duration)
        return formattedDuration!
    }
    
    private func returnTotalDownloadTimeInSeconds(speedTestRate: Double) -> Double{
        let bundleSizes = totalBundleSize
        let bundleInstallTimeTotal = totalInstallTime
        
        guard let jamfBufferTime = UserDefaults.standard.string(forKey: AppBundles.jamfBufferTime) else {
            return 1
        }
        
        let totalJAMFBufferTime = Double(jamfBufferTime)! * Double(bundleChoiceSelected.count)
        
        let sum = bundleSizes.reduce(0, +)
        let installTimeSum = bundleInstallTimeTotal.reduce(0, +)
        
        let duration: TimeInterval = ((sum / speedTestRate) + installTimeSum + totalJAMFBufferTime)
        
        return duration
    }
    
    private func displayTotalDownloadtime(speedTestRate: Double) -> String{
        let bundleSizes = totalBundleSize
        let bundleInstallTimeTotal = totalInstallTime
        
        guard let jamfBuffer = UserDefaults.standard.string(forKey: AppBundles.jamfBufferTime) else {
            return String(60)
        }
        let jamfBufferTimeTotal = Double(bundleChoiceSelected.count) * Double(jamfBuffer)!
        
        let sum = bundleSizes.reduce(0, +)
        let installTimeSum = bundleInstallTimeTotal.reduce(0, +)
        
        
        let duration: TimeInterval = ((sum / speedTestRate) + installTimeSum + jamfBufferTimeTotal)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDurationForSum = formatter.string(from: duration)
        return formattedDurationForSum!
    }
    
    private func syncToggleStateWithSelectionArray(bundleToggle: NSButton, bundleArrayMemberName: String, bundleSize: String, bundleInstallTimeInSeconds: String, index: Int) {
        if bundleToggle.state == .on {
            bundleChoiceSelected.insert(bundleArrayMemberName)
            if let bundleSize = UserDefaults.standard.string(forKey: bundleSize) {
                if let bundleInstallTimeInSeconds = UserDefaults.standard.string(forKey: bundleInstallTimeInSeconds) {
                    totalBundleSize[index] = Double(bundleSize)!
                    totalInstallTime[index] = Double(bundleInstallTimeInSeconds)!
                }
            }  else {
                totalBundleSize[index] = 0.0
                totalInstallTime[index] = 0.0
            }
        } else {
            bundleChoiceSelected.remove(bundleArrayMemberName)
            totalBundleSize[index] = 0.0
            totalInstallTime[index] = 0.0
        }
        UserDefaults.standard.set(Array(bundleChoiceSelected), forKey: AppBundles.bundleArrayKey)
        UserDefaults.standard.synchronize()
        if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
            
            let totalDownloadTime = displayTotalDownloadtime(speedTestRate: Double(speedTestResult)!)
            totalDownloadTimeLabel.fadeTransition(0.25)
            totalDownloadTimeLabel.stringValue = "+ \(totalDownloadTime)"
        }
        checkForEmptyChoiceArrayAndSetButtonDisplay()
    }
    
    private func factorIndvidualBundleDownloadTime(bundleDownloadTimeLabel: NSTextField,
                                                   speedTestResult: String,
                                                   jamfBufferTime: String,
                                                   bundleSize: String,
                                                   bundleInstallTimeInSeconds: String,
                                                   bundleArrayIndex: Int) {
        if let bundleSize = UserDefaults.standard.string(forKey: bundleSize) {
            if let bundleInstallTimeInSeconds = UserDefaults.standard.string(forKey: bundleInstallTimeInSeconds) {
                bundleDownloadTimeLabel.stringValue = "+ \(timeForDownload(speedTestRate: Double(speedTestResult)!, bundleSize: Double(bundleSize)!, bundleInstallTimeInSeconds: Double(bundleInstallTimeInSeconds)!, jamfComBufferTimeInSeconds: Double(jamfBufferTime)!))"
            }
        }
    }
    
    private func displayIndividualDownloadTimes() {
        if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
            if let jamfBufferTime = UserDefaults.standard.string(forKey: AppBundles.jamfBufferTime) {
                factorIndvidualBundleDownloadTime(bundleDownloadTimeLabel: aDownloadTimeLabel,
                                                  speedTestResult: speedTestResult,
                                                  jamfBufferTime: jamfBufferTime,
                                                  bundleSize: AppBundles.Bundle.A.DownloadTime.size,
                                                  bundleInstallTimeInSeconds: AppBundles.Bundle.A.DownloadTime.time,
                                                  bundleArrayIndex: 0)
                factorIndvidualBundleDownloadTime(bundleDownloadTimeLabel: bDownloadTimeLabel,
                                                  speedTestResult: speedTestResult,
                                                  jamfBufferTime: jamfBufferTime,
                                                  bundleSize: AppBundles.Bundle.B.DownloadTime.size,
                                                  bundleInstallTimeInSeconds: AppBundles.Bundle.B.DownloadTime.time,
                                                  bundleArrayIndex: 1)
                factorIndvidualBundleDownloadTime(bundleDownloadTimeLabel: cDownloadTimeLabel,
                                                  speedTestResult: speedTestResult,
                                                  jamfBufferTime: jamfBufferTime,
                                                  bundleSize: AppBundles.Bundle.C.DownloadTime.size,
                                                  bundleInstallTimeInSeconds: AppBundles.Bundle.C.DownloadTime.time,
                                                  bundleArrayIndex: 2)
            }
        }
    }
   
    private func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = cancelHeader
        alert.informativeText = cancelMessage
        alert.alertStyle = .critical
        if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
            let totalDownloadTime = displayTotalDownloadtime(speedTestRate: Double(speedTestResult)!)
            alert.informativeText = "\(cancelMessage) \n \n Estimated install time : \(totalDownloadTime)"
        }
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.beginSheetModal(for: NSApp.keyWindow!, completionHandler: { [unowned self] (returnCode) -> Void in
            if returnCode == NSApplication.ModalResponse.alertSecondButtonReturn {
                self.returnCode = "Yes"
                if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
                    let totalDownloadTimeInSeconds = self.returnTotalDownloadTimeInSeconds(speedTestRate: Double(speedTestResult)!)
                    UserDefaults.standard.set(String(totalDownloadTimeInSeconds), forKey: AppBundles.installClockTotal)
                }
                self.performSegue(withIdentifier: SegueDestinationID.ForwardTo.bundleInstallationChildViewController, sender: self)
            } else {
                self.returnCode = "No"
            }
        })
        return true
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier! == SegueDestinationID.Popover.BundleSelectionChildViewController.essentials {
            let popoverVC: BundlePopOverViewController = segue.destinationController as! BundlePopOverViewController
            let bundleInfo = DefineBundleInfoPopover.init(
                bundleTitle: AppBundles.Bundle.B.InfoPopover.header,
                bundleDescription: AppBundles.Bundle.B.InfoPopover.mainDescription,
                appTitles: AppBundles.Bundle.B.InfoPopover.titles,
                appDescriptions: AppBundles.Bundle.B.InfoPopover.descriptions,
                appIcons: AppBundles.Bundle.B.InfoPopover.icons)
            
            popoverVC.recievedBundleTitleString = bundleInfo.bundleTitle
            popoverVC.recievedBundleDescriptionString = bundleInfo.descriptionText
            popoverVC.recievedListOfTitles = bundleInfo.appTitles
            popoverVC.recievedListOfDescriptions = bundleInfo.appDescriptions
            popoverVC.recievedListOfIcons = bundleInfo.appIcons
        }
        
        if segue.identifier! == SegueDestinationID.Popover.BundleSelectionChildViewController.productivity {
            let popoverVC: BundlePopOverViewController = segue.destinationController as! BundlePopOverViewController
            let bundleInfo = DefineBundleInfoPopover.init(
                bundleTitle: AppBundles.Bundle.C.InfoPopover.header,
                bundleDescription: AppBundles.Bundle.C.InfoPopover.mainDescription,
                appTitles: AppBundles.Bundle.C.InfoPopover.titles,
                appDescriptions: AppBundles.Bundle.C.InfoPopover.descriptions,
                appIcons: AppBundles.Bundle.C.InfoPopover.icons)
            
            popoverVC.recievedBundleTitleString = bundleInfo.bundleTitle
            popoverVC.recievedBundleDescriptionString = bundleInfo.descriptionText
            popoverVC.recievedListOfTitles = bundleInfo.appTitles
            popoverVC.recievedListOfDescriptions = bundleInfo.appDescriptions
            popoverVC.recievedListOfIcons = bundleInfo.appIcons
        }
    }
    
    @IBAction func aToggleClicked(_ sender: NSButton) {
            syncToggleStateWithSelectionArray(bundleToggle: aToggle,
                                          bundleArrayMemberName: AppBundles.PersistanceArrayMember.a,
                                          bundleSize: AppBundles.Bundle.A.DownloadTime.size,
                                          bundleInstallTimeInSeconds: AppBundles.Bundle.A.DownloadTime.time,
                                          index: 0)
    }
    
    @IBAction func bToggleClicked(_ sender: NSButton) {
        syncToggleStateWithSelectionArray(bundleToggle: bToggle,
                                          bundleArrayMemberName: AppBundles.PersistanceArrayMember.b,
                                          bundleSize: AppBundles.Bundle.B.DownloadTime.size,
                                          bundleInstallTimeInSeconds: AppBundles.Bundle.B.DownloadTime.time,
                                          index: 1)
    }
    
    @IBAction func cToggleClicked(_ sender: NSButton) {
        syncToggleStateWithSelectionArray(bundleToggle: cToggle,
                                          bundleArrayMemberName: AppBundles.PersistanceArrayMember.c,
                                          bundleSize: AppBundles.Bundle.C.DownloadTime.size,
                                          bundleInstallTimeInSeconds: AppBundles.Bundle.C.DownloadTime.time,
                                          index: 2)
    }
    
    @IBAction func essentialsInfoButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.BundleSelectionChildViewController.essentials, sender: self)
    }
    
    @IBAction func productivityInfoButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.Popover.BundleSelectionChildViewController.productivity, sender: self)
    }
    
    @IBAction func skipButtonClicked(_ sender: NSButton) {
        self.performSegue(withIdentifier: SegueDestinationID.SkipTo.setupCompleteChildViewConroller, sender: self)
    }
    
    @IBAction func installSelectedBundlesButtonClicked(_ sender: NSButton) {
        let dispatchGroup = DispatchGroup()
        if NetworkValidationService.sharedInstance.isConnectedToNetwork() == true {
            if let env = UserDefaults.standard.string(forKey: BundleSelectionChildVC_Constants.Keys.environment) {
                if env == "eng" {
                    jpsHealthCheckServiceURL = JPSPaths.HealthCheckURLs.Eng.healthCheckURL
                }
                if env == "qa" {
                    jpsHealthCheckServiceURL = JPSPaths.HealthCheckURLs.QA.healthCheckURL
                }
                if env == "prod" {
                    jpsHealthCheckServiceURL = JPSPaths.HealthCheckURLs.Prod.healthCheckURL
                }
            }
            dispatchGroup.enter()
            NetworkValidationService.sharedInstance.checkForJPSAvailability(jpsURL: jpsHealthCheckServiceURL) { (result) -> () in
                self.jpsCheckResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                if self.jpsCheckResult != 200 {
                    IssueAlertService.sharedInstance.displaySheetNetworkUnreachable(message: AlertText.NetworkValidationMessaging.External.jps)
                } else {
                    if self.bundleChoiceSelected.count >= 1 {
                        if let speedTestResult = UserDefaults.standard.string(forKey: AppBundles.speedRate) {
                            let totalDownloadTimeInSeconds = self.returnTotalDownloadTimeInSeconds(speedTestRate: Double(speedTestResult)!)
                            UserDefaults.standard.set(String(totalDownloadTimeInSeconds), forKey: AppBundles.installClockTotal)
                            if self.returnTotalDownloadTimeInSeconds(speedTestRate: Double(speedTestResult)!) > CalculationThresholds.estimatedDownloadTimeInSecondsThreshold {
                                _ = self.dialogOKCancel(question: "Ok?", text: "Choose your answer.")
                            } else {
                                self.performSegue(withIdentifier: SegueDestinationID.ForwardTo.bundleInstallationChildViewController, sender: self)
                           }
                        }
                    }
                }
            }
        } else {
            IssueAlertService.sharedInstance.displaySheetNetworkUnreachable(message: AlertText.NetworkValidationMessaging.External.network)
        }
    }
}
