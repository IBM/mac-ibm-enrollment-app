//
//  BundleSelectionViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/31/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This class manage the bundle selection page.
class BundleSelectionViewController: NSViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: InfoLabelView!
    @IBOutlet weak var subtitleLabel: InfoLabelView!
    @IBOutlet weak var bundlesCollectionView: NSCollectionView!
    @IBOutlet weak var bottomRightButton: NSButton!
    @IBOutlet weak var bottomLeftButton: NSButton!
    @IBOutlet weak var bottomRightLabel: NSTextField!
    
    // MARK: - Variables
    
    static let controllerID = "BundleSelectionViewController"
    private var selectedBundles: Set<String> = .init() {
        didSet {
            bottomLeftButton.isHidden = !selectedBundles.isEmpty
            bottomRightButton.isHidden = selectedBundles.isEmpty
            bottomRightLabel.isHidden = selectedBundles.isEmpty
            bottomRightLabel.stringValue = !selectedBundles.isEmpty ? "+ \(getEstimatedTime())" : ""
        }
    }
    private var pageInfo: BundleSelectionPage?
    var jpsCheckResult: Int?
    var jpsHealthCheckServiceURL: String = Environment.current.healthCheckURL
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageInfo = Context.main?.dataSet.bundleSelectionPage
        setValuesToFactoryDefaults()
        configureCollectionView()
        configureLabels()
        configureButtons()
    }
    
    // MARK: - Private methods
    
    private func setValuesToFactoryDefaults() {
        Context.main?.dataSet.bundleInstallationPage?.bundleInstallationStatus = false
        Context.main?.dataSet.selectedBundles = []
        
        Context.main?.dataSet.bundleSelectionPage?.bundles.forEach({ bundle in
            bundle.status = .installationPending
            bundle.bundleMessaging = ""
            let appArray = bundle.apps
            bundle.apps = appArray.map({ app in
                var updatedApp = app
                updatedApp.status = .installationPending
                return updatedApp
            })
        })
    }
    
    private func configureCollectionView() {
        bundlesCollectionView.register(NSNib(nibNamed: "SelectableBundleCell", bundle: nil), forItemWithIdentifier: SelectableBundleCell.reuseIdentifier)
        bundlesCollectionView.enclosingScrollView?.scrollerStyle = .overlay
    }
    
    private func configureLabels() {
        titleLabel.labelledInfo = pageInfo?.title
        titleLabel.font = .systemFont(ofSize: 28)
        subtitleLabel.labelledInfo = pageInfo?.subtitle
        bottomRightLabel.placeholderString = "installationBundleSelectionPageNoTime".localized
        bottomRightLabel.isHidden = true
    }
    
    private func configureButtons() {
        bottomLeftButton.title = "buttonLabelSkip".localized
        bottomRightButton.title = "buttonLabelNext".localized
        bottomRightButton.set(textColor: .white, underline: .zero)
        bottomRightButton.isHidden = true
    }
    
    /// This method translate the total bundles size and time to download and install in a user friendly estimated time string.
    /// - Returns: the string that show the estimated time needed to download and install the bundle.
    private func getEstimatedTime() -> String {
        let duration: TimeInterval = getEstimatedTimeInSeconds()
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDuration = formatter.string(from: duration)
        return formattedDuration!
    }
    
    /// This method translate the total bundles size and time to download and install in a double value that rapresent the total time in seconds needed.
    /// - Returns: the double value that rapresent the estimated time in seconds needed to download and install the bundle.
    private func getEstimatedTimeInSeconds() -> Double {
        guard let speedTestRateString = Context.main?.dataSet.networkInfo?.speedTestResult, let speedTestRate = Double(speedTestRateString),
            let jamfComBufferTimeInSecondsString = Context.main?.dataSet.networkInfo?.jpsCommSeconds, let jamfComBufferTimeInSeconds = Double(jamfComBufferTimeInSecondsString),
            let bundleSizes = self.getSelectedBundlesSize(),
            let bundlesInstallTimeInSeconds = self.getSelectedBundlesTime() else {
            return 1
        }

        let totalJAMFBufferTime = jamfComBufferTimeInSeconds * Double(selectedBundles.count)
                
        let duration: TimeInterval = ((bundleSizes / speedTestRate) + bundlesInstallTimeInSeconds + totalJAMFBufferTime)
        
        return duration
    }
    
    private func getSelectedBundlesSize() -> Double? {
        var size: Double = 0
        
        for bundle in selectedBundles {
            guard let bundleSizeString = self.pageInfo?.bundles.first(where: { $0.key == bundle })?.size, let bundleSize = Double(bundleSizeString) else { return nil }
            size += bundleSize
        }
        
        return size > 0 ? size : nil
    }
    
    private func getSelectedBundlesTime() -> Double? {
        var time: Double = 0
        
        for bundle in selectedBundles {
            guard let bundleTimeString = self.pageInfo?.bundles.first(where: { $0.key == bundle })?.time, let bundletime = Double(bundleTimeString) else { return nil }
            time += bundletime
        }
        
        return time > 0 ? time : nil
    }
    
    private func checkNetwork(_ completion: @escaping () -> Void, error: @escaping (String) -> Void) {
        let dispatchGroup = DispatchGroup()
        if NetworkValidationService.sharedInstance.isConnectedToNetwork() {
            dispatchGroup.enter()
            NetworkValidationService.sharedInstance.checkForJPSAvailability(jpsURL: jpsHealthCheckServiceURL) { result in
                self.jpsCheckResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                if self.jpsCheckResult != 200 {
                    error(AlertText.NetworkValidationMessaging.External.jps)
                } else {
                    completion()
                }
            }
        } else {
            error(AlertText.NetworkValidationMessaging.External.network)
        }
    }

    // MARK: - Actions
    
    @IBAction func didPressBottomLeftButton(_ sender: NSButton) {
        self.performSegue(withIdentifier: "skipToSummaryPage", sender: self)
    }
    
    @IBAction func didPressBottomRightButton(_ sender: NSButton) {
        bottomRightButton.isEnabled = false
        Context.main?.dataSet.selectedBundles = selectedBundles.map({ $0 })
        checkNetwork({
            if self.selectedBundles.count >= 1 {
                if self.getEstimatedTimeInSeconds() > 3000.0 {
                    let alert = NSAlert()
                    alert.messageText = "bundleSelectionAlertTitle".localized
                    alert.alertStyle = .critical
                    alert.informativeText = String(format: "estimatedInstallTimeMessage".localized, "bundleSelectionAlertMessage".localized, self.getEstimatedTime())
                    alert.addButton(withTitle: "labelNo".localized)
                    alert.addButton(withTitle: "labelYes".localized)
                    alert.beginSheetModal(for: NSApp.keyWindow!, completionHandler: { [unowned self] (returnCode) -> Void in
                        if returnCode == NSApplication.ModalResponse.alertSecondButtonReturn {
                            self.performSegue(withIdentifier: "goToInstallationPage", sender: self)
                        } else {
                            self.bottomRightButton.isEnabled = true
                        }
                    })
                } else {
                    self.performSegue(withIdentifier: "goToInstallationPage", sender: self)
                }
            }
        }, error: { error in
            let alert = NSAlert()
            alert.messageText = error
            alert.alertStyle = .critical
            alert.addButton(withTitle: "buttonLabelOk".localized)
            alert.beginSheetModal(for: NSApp.keyWindow!)
            self.bottomRightButton.isEnabled = true
        })
        
    }
}

// MARK: - Collection View delegate and data source.

extension BundleSelectionViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageInfo?.bundles.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = bundlesCollectionView.makeItem(withIdentifier: SelectableBundleCell.reuseIdentifier, for: indexPath) as? SelectableBundleCell,
            let bundle = pageInfo?.bundles[indexPath.item] else { return NSCollectionViewItem() }
        item.configure(with: bundle)
        item.delegate = self
        return item
    }
}

// MARK: - Collection View flow layout delegate.

extension BundleSelectionViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        guard let bundle = pageInfo?.bundles[indexPath.item] else { return CGSize(width: 0, height: 0) }
        let label = NSTextField(labelWithAttributedString: NSAttributedString(string: bundle.description.localized, attributes: [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 11)]))
        return CGSize(width: 471, height: 62+((CGFloat(Int(label.bounds.width/445)+1))*14))
    }
}

// MARK: - Bundle cell delegate

extension BundleSelectionViewController: SelectableBundleCollectionViewItemDelegate {
    func didPressedInfoButton(_ sender: NSButton, infos: EnrollmentBundle) {
        let appsPopupViewController = BundlePopOverViewController(with: infos)
        self.present(appsPopupViewController, asPopoverRelativeTo: sender.convert(sender.bounds, to: self.view), of: self.view, preferredEdge: .maxX, behavior: .semitransient)
    }
    
    func didSelectedBundle(_ bundleKey: String) {
        self.selectedBundles.insert(bundleKey)
    }
    
    func didDeselectBundle(_ bundleKey: String) {
        self.selectedBundles.remove(bundleKey)
    }
}
