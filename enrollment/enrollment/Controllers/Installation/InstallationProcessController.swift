//
//  InstallationProcessController.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/20/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

/// This protocol provide an interface between the installation process controller and the installation view controller
protocol InstallationProcessControllerDelegate: class {
    func bundleStatusUpdated(_ bundleKey: String, newStatus: EnrollmentBundle.InstallationStatus)
    func bundleMessageUpdated(_ bundleKey: String, newMessage: String)
    func appStatusUpdated(_ appKey: String, newStatus: EnrollmentBundle.InstallationStatus)
}

/// This class provide a controller that handle the update of the installation status for the bundles.
public final class InstallationProcessController {
    
    // MARK: - Variables
    
    private var selectedBundles: [EnrollmentBundle]
    weak var delegate: InstallationProcessControllerDelegate?
    private var uiUpdateQueue: DispatchQueue
    
    // MARK: - Initializers
    
    init(with enrollmentBundles: [EnrollmentBundle]) {
        self.selectedBundles = enrollmentBundles
        self.uiUpdateQueue = DispatchQueue(label: "com.ibm.enrollment.installationProcessUpdate", qos: .userInteractive)
    }
    
    // MARK: - Private methods
    
    /// This method handle the old way to update the UI. This will be deprecated as soon as the new plist format and the deep link engine will go in production
    @objc
    private func updateStatus(_ notification: Notification) {
        guard let key = notification.userInfo?["key"] as? String,
              let newStatus = notification.userInfo?["newStatus"] as? EnrollmentBundle.InstallationStatus else {
            return
        }
        if selectedBundles.contains(where: { $0.key == key }) {
            uiUpdateQueue.async {
                self.delegate?.bundleStatusUpdated(key, newStatus: newStatus)
            }
        } else {
            for bundle in selectedBundles where bundle.apps.contains(where: { $0.key == key }) {
                uiUpdateQueue.async {
                    self.delegate?.appStatusUpdated(key, newStatus: newStatus)
                }
            }
        }
    }

    @objc
    private func updateBundleMessaging(_ notification: Notification) {
        guard let key = notification.userInfo?["key"] as? String,
              let newMessage = notification.userInfo?["newMessage"] as? String else {
            return
        }
        if selectedBundles.contains(where: { $0.key == key }) {
            uiUpdateQueue.async {
                self.delegate?.bundleMessageUpdated(key, newMessage: newMessage)
            }
        }
    }

    // MARK: - Public methods

    public func startListeningForUpdate() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateBundleMessaging), name: Constants.NewMessageReceivedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateStatus), name: Constants.NewStatusReceivedNotification, object: nil)
    }

    public func stopListeningForUpdate() {
        NotificationCenter.default.removeObserver(self)
    }
}
