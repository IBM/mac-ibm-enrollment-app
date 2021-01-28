//
//  SelectableBundleCell.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 3/31/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/// This protocol provide an interface between the bundle selection page and the bundle cell.
protocol SelectableBundleCollectionViewItemDelegate: class {
    func didPressedInfoButton(_ sender: NSButton, infos: EnrollmentBundle)
    func didSelectedBundle(_ bundleKey: String)
    func didDeselectBundle(_ bundleKey: String)
}

/// This class manage the cell that represent the bundle inside the bundle selection page.
class SelectableBundleCell: NSCollectionViewItem, LoadableNib {

    // MARK: - Outlets
    
    @IBOutlet weak var checkBox: NSButton!
    @IBOutlet weak var titleHelpLabel: InfoLabelView!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    
    // MARK: - Variables
    
    var contentView: NSView! {
        return self.view
    }
    private var bundle: EnrollmentBundle?
    static var reuseIdentifier = NSUserInterfaceItemIdentifier("SelectableBundleCell")
    public weak var delegate: SelectableBundleCollectionViewItemDelegate?
    
    // MARK: - Public methods
    
    /// This method configure the cell with the information of the given bundle.
    /// - Parameter bundle: the given bundle.
    func configure(with bundle: EnrollmentBundle) {
        self.bundle = bundle
        self.descriptionLabel.placeholderString = "installationBundleSelectionPageNoDescription".localized
        self.timeLabel.placeholderString = "installationBundleSelectionPageNoTime".localized
        self.descriptionLabel.stringValue = bundle.description.localized
        var attributedTitle: NSMutableAttributedString?
        if bundle.recommended {
            attributedTitle = NSMutableAttributedString(string: bundle.title.localized)
            attributedTitle?.append(NSAttributedString(string: " " + "installationBundleSelectionPageRecommended".localized, attributes: [.foregroundColor: NSColor.red, .font: NSFont.systemFont(ofSize: 11), .baselineOffset: 3]))
        }
        var infoSection = InfoSection(fields: [])
        for app in bundle.apps {
            infoSection.fields.append(InfoField(label: app.title.localized, description: app.description.localized, iconName: app.icon))
        }
        let infoLabel = InfoLabel(bundle.title.localized,
                                  attributedLabel: attributedTitle,
                                  withHelpSection: infoSection)
        self.titleHelpLabel.labelledInfo = infoLabel
        self.titleHelpLabel.onInfoButtonPressed = { button in
            self.delegate?.didPressedInfoButton(button, infos: bundle)
        }
        self.timeLabel.stringValue = self.estimatedTime()
    }
    
    // MARK: - Private methods
    
    /// This method translate the bundle size and time to download and install in a user friendly estimated time string.
    /// - Returns: the string that show the estimated time needed to download and install the bundle.
    private func estimatedTime() -> String {
        guard let speedTestRateString = Context.main?.dataSet.networkInfo?.speedTestResult, let speedTestRate = Double(speedTestRateString),
            let jamfComBufferTimeInSecondsString = Context.main?.dataSet.networkInfo?.jpsCommSeconds, let jamfComBufferTimeInSeconds = Double(jamfComBufferTimeInSecondsString),
            let bundleSizeString = self.bundle?.size, let bundleSize = Double(bundleSizeString),
            let bundleInstallTimeInSecondsString = self.bundle?.time, let bundleInstallTimeInSeconds = Double(bundleInstallTimeInSecondsString) else {
            return ""
        }
        
        let duration: TimeInterval = ((bundleSize / speedTestRate) + bundleInstallTimeInSeconds + jamfComBufferTimeInSeconds)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDuration = formatter.string(from: duration)
        return "+ " + formattedDuration!
    }
    
    // MARK: - Actions
    
    @IBAction func didSelectedBundle(_ sender: NSButton) {
        guard let bundleKey = self.bundle?.key else { return }
        switch sender.state {
        case .on:
            delegate?.didSelectedBundle(bundleKey)
        case .off:
            delegate?.didDeselectBundle(bundleKey)
        default:
            break
        }
    }
}
