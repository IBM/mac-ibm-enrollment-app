//
//  BundleInstallationViewController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/9/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa
import Combine

/// This class manage the bundle installation page.
class BundleInstallationViewController: NSViewController {
    
    struct CellLayout {
        var bundle: EnrollmentBundle
        var isExpanded: Bool
        var height: CGFloat
    }

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: InfoLabelView!
    @IBOutlet weak var subtitleLabel: InfoLabelView!
    @IBOutlet weak var bundlesStackView: CustomStackView!
    @IBOutlet weak var bottomRightButton: NSButton!
    @IBOutlet weak var bottomLeftLabel: NSTextField!
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    
    private var viewModel = BundleInstallationViewModel()
    private var timer: Timer?
    private var timeLeft: Double = 0
    private var installationProcessController: InstallationProcessController?
    private var bundleStackViewItems: [BundleInstallationStackViewItem] = []
    private var appStackViewItems: [[AppInstallationStackViewItem]] = []

    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        configureLabels()
        configureButtons()
        configureTimer()
        configureController()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        PrivilegedHelperController.shared.processJAMFPolicy(Context.main?.dataSet.policies.bundleInstallationPolicy ?? "")
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer?.invalidate()
        timer = nil
        installationProcessController?.stopListeningForUpdate()
    }
    
    // MARK: - Private methods
    
    private func configureLabels() {
        titleLabel.labelledInfo = Context.main?.dataSet.bundleInstallationPage?.title
        titleLabel.font = .systemFont(ofSize: 28)
        if Context.main?.dataSet.bundleInstallationPage?.subtitle == nil {
            subtitleHeight.constant = 0
            subtitleLabel.isHidden = true
        } else {
            subtitleLabel.labelledInfo = Context.main?.dataSet.bundleInstallationPage?.subtitle
        }
        timeLeft = viewModel.getEstimatedTime()
        bottomLeftLabel.stringValue = "installationBundleInstallationPageSubtitle".localized + "\n" + viewModel.formatTimeInterval(for: timeLeft)
    }
    
    private func configureButtons() {
        bottomRightButton.title = "buttonLabelNext".localized
        bottomRightButton.set(textColor: .white, underline: .zero)
        bottomRightButton.isEnabled = false
    }
    
    private func configureStackView() {
        bundlesStackView.setHuggingPriority(NSLayoutConstraint.Priority.defaultHigh, for: .horizontal)
        bundlesStackView.enclosingScrollView?.scrollerStyle = .overlay
        viewModel.selectedBundles.forEach({ bundle in
            let bundleStackViewItem = BundleInstallationStackViewItem(frame: .zero)
            bundleStackViewItem.configure(with: bundle, isExpanded: false)
            bundleStackViewItem.delegate = self
            bundleStackViewItems.append(bundleStackViewItem)
            bundlesStackView.addArrangedSubview(bundleStackViewItem)
            
            var bundleAppStackViewItems: [AppInstallationStackViewItem] = []
            bundle.apps.forEach({ app in
                let appStackViewItem = AppInstallationStackViewItem(frame: .zero)
                appStackViewItem.configure(with: app)
                bundleAppStackViewItems.append(appStackViewItem)
                bundlesStackView.addArrangedSubview(appStackViewItem)
            })
            appStackViewItems.append(bundleAppStackViewItems)
        })
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            self.updateCounter()
        }
    }
    
    private func configureController() {
        installationProcessController = InstallationProcessController(with: viewModel.selectedBundles)
        installationProcessController?.delegate = self
        installationProcessController?.startListeningForUpdate()
    }
    
    private func updateCounter() {
        timeLeft -= 60
        bottomLeftLabel.stringValue = "installationBundleInstallationPageSubtitle".localized + "\n" + viewModel.formatTimeInterval(for: timeLeft)
        view.needsDisplay = true
    }
    
    private func checkInstallationStatus() {
        var completed: Bool = true
        for bundle in viewModel.selectedBundles {
            completed = completed && (bundle.status == .installed || bundle.status == .errorDuringInstallation)
        }
        bottomRightButton.isEnabled = completed
        bottomLeftLabel.isHidden = completed
    }
    
    // MARK: - Actions
    
    @IBAction func didSelectBottomRightButton(_ sender: NSButton) {
        Context.main?.dataSet.phase = "2"
        self.performSegue(withIdentifier: "goToPostInstallationPage", sender: self)
    }
}

// MARK: - Bundle cell delegate

extension BundleInstallationViewController: BundleInstallationStackViewItemDelegate {
    func didPressShowHideButton(_ sender: BundleInstallationStackViewItem) {
        guard let bundleIndex = self.viewModel.selectedBundles.firstIndex(of: sender.bundle) else { return }
        for appView in appStackViewItems[bundleIndex] {
            appView.isVisible.toggle()
        }
    }
}

// MARK: - Installation process controller delegate

extension BundleInstallationViewController: InstallationProcessControllerDelegate {
    func bundleStatusUpdated(_ bundleKey: String, newStatus: EnrollmentBundle.InstallationStatus) {
        guard let index = viewModel.index(forBundleKey: bundleKey) else { return }
        DispatchQueue.main.async {
            self.bundleStackViewItems[index].updateBundle(with: newStatus)
            self.checkInstallationStatus()
        }
    }
    
    func bundleMessageUpdated(_ bundleKey: String, newMessage: String) {
        guard let index = viewModel.index(forBundleKey: bundleKey) else { return }
        DispatchQueue.main.async {
            self.bundleStackViewItems[index].updateBundle(with: newMessage)
            self.checkInstallationStatus()
        }
    }
    
    func appStatusUpdated(_ appKey: String, newStatus: EnrollmentBundle.InstallationStatus) {
        guard let (bundleIndex, appIndex) = viewModel.index(forAppKey: appKey) else { return }
        DispatchQueue.main.async {
            self.appStackViewItems[bundleIndex][appIndex].updateApp(with: newStatus)
            self.checkInstallationStatus()
        }
    }
}
