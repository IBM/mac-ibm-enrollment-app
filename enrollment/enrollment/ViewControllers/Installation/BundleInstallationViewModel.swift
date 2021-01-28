//
//  BundleInstallationViewModel.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 4/14/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import Combine

/// This class handle the logic behind the update of the views of the Installation process and provide usefull methods to the viewController.
class BundleInstallationViewModel {
    
    // MARK: - Enums
    
    enum State {
        case readyToStart
        case started(bundle: EnrollmentBundle)
        case updated(bundle: EnrollmentBundle)
        case completed(bundle: EnrollmentBundle)
        case ended
    }
    
    // MARK: - Variables
    
    var selectedBundles: [EnrollmentBundle] {
        guard let context = Context.main?.dataSet else { return [] }
        return context.bundleSelectionPage?.bundles.filter({ context.selectedBundles.contains($0.key) }) ?? []
    }
    var installationProcessState: State
    
    // MARK: - Initializer
    
    init() {
        installationProcessState = .readyToStart
    }
    
    // MARK: - Public methods
    
    /// This method translate the total size and time of selected bundles to download and install in a user friendly estimated time string.
    /// - Returns: the string that show the estimated time needed to download and install the bundle.
    func getEstimatedTime() -> Double {
        guard let speedTestRateString = Context.main?.dataSet.networkInfo?.speedTestResult, let speedTestRate = Double(speedTestRateString),
            let jamfComBufferTimeInSecondsString = Context.main?.dataSet.networkInfo?.jpsCommSeconds, let jamfComBufferTimeInSeconds = Double(jamfComBufferTimeInSecondsString),
            let bundlesSize = self.getSelectedBundlesSize(),
            let bundlesInstallTimeInSeconds = self.getSelectedBundlesTime() else {
            return 0
        }
        
        return ((bundlesSize / speedTestRate) + bundlesInstallTimeInSeconds + jamfComBufferTimeInSeconds)
    }
    
    func formatTimeInterval(for timeLeft: Double) -> String {
        guard timeLeft > 0 else { return "installationBundleSelectionPageNoTime".localized }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [ .day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        let formattedDuration = formatter.string(from: timeLeft)
        return formattedDuration!
    }
    
    /// This method return the index of the bundle in the "selectedBundles" array that contain the app with the given app key.
    /// - Parameter appKey: the given app key.
    /// - Returns: the indexes of the bundle and of the app in the bundle (bundleIndex, appIndex), nil if not present.
    func index(forAppKey appKey: String) -> (bundleIndex: Int, appIndex: Int)? {
        for (bundleIndex, bundle) in selectedBundles.enumerated() {
            if let appIndex = bundle.apps.firstIndex(where: { $0.key == appKey }) {
                return (bundleIndex, appIndex)
            }
        }
        return nil
    }
    
    /// This method return the index of the bundle in the "selectedBundles" array with the given bundle key.
    /// - Parameter bundleKey: the given bundle key.
    /// - Returns: the index of the bundle, nil if not present.
    func index(forBundleKey bundleKey: String) -> Int? {
        return selectedBundles.firstIndex(where: { $0.key == bundleKey })
    }
    
    // MARK: - Private methods
    
    private func getSelectedBundlesSize() -> Double? {
        var size: Double = 0
        
        for bundle in selectedBundles {
            guard let bundleSizeString = bundle.size, let bundleSize = Double(bundleSizeString) else { return nil }
            size += bundleSize
        }
        
        return size > 0 ? size : nil
    }
    
    private func getSelectedBundlesTime() -> Double? {
        var time: Double = 0
        
        for bundle in selectedBundles {
            guard let bundleTimeString = bundle.time, let bundletime = Double(bundleTimeString) else { return nil }
            time += bundletime
        }
        
        return time > 0 ? time : nil
    }
}
