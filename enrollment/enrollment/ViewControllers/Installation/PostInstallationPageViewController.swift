//
//  PostInstallationPageViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/9/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa
import ServiceManagement

/// This class handle the summary page.
class PostInstallationPageViewController: NSViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: InfoLabelView!
    @IBOutlet weak var subtitleLabel: InfoLabelView!
    @IBOutlet weak var subtitleHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var summaryCollectionView: NSCollectionView!
    @IBOutlet weak var checkBottomLeftButton: NSButton!
    @IBOutlet weak var bottomRightButton: NSButton!
    
    // MARK: - Variables
    
    static let controllerID = "PostInstallationPageViewController"
    private let postInstallationPageData = Context.main?.dataSet.postInstallationPage
    private var timeout: Int {
        return postInstallationPageData?.restartTimeout ?? 300
    }
    private var countdown: Int = 0
    private var timer: Timer?
    private var needsRestart: Bool {
        return postInstallationPageData?.needsRestart ?? false
    }
    
    // MARK: - Instances methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureButtons()
        configureCollectionView()
        configureTimerIfNeeded()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private methods
    
    private func configureLabels() {
        titleLabel.labelledInfo = postInstallationPageData?.title
        titleLabel.font = .systemFont(ofSize: 28)
        guard postInstallationPageData?.subtitle != nil else {
            subtitleLabel.isHidden = true
            return
        }
        subtitleLabel.labelledInfo = postInstallationPageData?.subtitle
    }
    
    private func configureCollectionView() {
        summaryCollectionView.register(NSNib(nibNamed: .init("SummaryItemCell"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SummaryItemCell"))
        summaryCollectionView.enclosingScrollView?.scrollerStyle = .overlay
    }
    
    private func configureButtons() {
        checkBottomLeftButton.title = "postInstallationPageFooterLabel".localized
        bottomRightButton.title = needsRestart ? "buttonLabelRestart".localized : "buttonLabelClose".localized
        bottomRightButton.set(textColor: .white, underline: .zero)
    }
    
    private func configureTimerIfNeeded() {
        if needsRestart {
            countdown = timeout
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateCounter()
        }
    }
    
    private func updateCounter() {
        if countdown >= 1 {
            bottomRightButton.title = "buttonLabelRestart".localized + " (\(countdown))"
            countdown -= 1
        } else {
            self.restartComputer()
        }
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
        if err != noErr {
            let failureAlert = NSAlert()
            failureAlert.messageText = NSLocalizedString("restartFailureMessage".localized, comment: "restartFailureComment".localized)
            failureAlert.runModal()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didPressBottomLeftButton(_ sender: NSButton) {
        let autoLaunch = sender.state == .on
        if SMLoginItemSetEnabled("com.ibm.EnrollmentLoginHelper" as CFString, autoLaunch) {
            if autoLaunch {
                NSLog("Login item added")
            } else {
                NSLog("Login item removed")
            }
        }
    }
    
    @IBAction func didPressBottomRightButton(_ sender: NSButton) {
        if needsRestart {
            restartComputer()
        } else {
            exit(0)
        }
    }
}

// MARK: - Collection view delegate and data source

extension PostInstallationPageViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return postInstallationPageData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = collectionView.makeItem(withIdentifier: SummaryItemCell.reuseIdentifier, for: indexPath) as? SummaryItemCell,
            let itemData = postInstallationPageData?.items[indexPath.item] else { return NSCollectionViewItem() }
        item.configure(with: itemData)
        item.delegate = self
        return item
    }
}

// MARK: - Collection view flow layout delegate

extension PostInstallationPageViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: 230, height: 90)
    }
}

// MARK: - Collection view item delegate

extension PostInstallationPageViewController: SummaryItemCellDelegate {
    func didPressItem(_ item: PostInstallationPage.Item) {
        switch item.ctaType {
        case .url:
            guard let string = item.ctaPayload else { return }
            NetworkValidationService.sharedInstance.verifyInternalURL(urlPath: string, completion: { isValid in
                guard isValid, let url = URL(string: string) else { return }
                NSWorkspace.shared.open(url)
            })
        case .policy:
            guard let policy = item.ctaPayload else { return }
            PrivilegedHelperController.shared.processJAMFPolicy(policy)
        case .none:
            break
        }
    }
}
