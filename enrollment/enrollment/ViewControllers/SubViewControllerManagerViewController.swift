//
//  SubViewControllerManagerViewController.swift
//  enrollment
//
//  Created by Simone Martorelli on 20/07/2020.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//
// swiftlint:disable function_body_length

import Cocoa

/// Parent view controller for the main window of the application.
class SubViewControllerManagerViewController: NSViewController {
    
    // MARK: - Variables
    
    static let registrationStoryboardName = "Registration"
    static let installationStoryboardName = "Installation"
    
    // MARK: - Instance methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
    }
    
    // MARK: - Private methods
    
    /// Define the target VC based on the phase defined in the context object.
    private func layoutSetup() {
        checkContextConsistency({ phase in
            var controllerID: String!
            var storyboardName: String!
            
            switch phase {
            case "0" :
                storyboardName = Self.registrationStoryboardName
                controllerID = MultipleRegistrationFieldsViewController.controllerID
            case "1" :
                storyboardName = Self.installationStoryboardName
                controllerID = BundleSelectionViewController.controllerID
            case "2" :
                storyboardName = Self.installationStoryboardName
                controllerID = PostInstallationPageViewController.controllerID
            case "3":
                storyboardName = Self.registrationStoryboardName
                controllerID = Context.main?.dataSet.registration?.registrationStatus ?? false ? PostRegistrationPageViewController.controllerID : MultipleRegistrationFieldsViewController.controllerID
            case "4":
                storyboardName = Self.registrationStoryboardName
                controllerID = PostRegistrationPageViewController.controllerID
            default:
                storyboardName = Self.registrationStoryboardName
                controllerID = MultipleRegistrationFieldsViewController.controllerID
            }
            
            let mainStoryboard: NSStoryboard = NSStoryboard(name: storyboardName, bundle: nil)
            guard let sourceViewController = mainStoryboard.instantiateController(withIdentifier: controllerID) as? NSViewController else { return }

            self.insertChild(sourceViewController, at: 0)
            self.view.addSubview(sourceViewController.view)
            self.view.frame = sourceViewController.view.frame
            
        }, errorHandler: { errorMessage in
            let sourceViewController = ConfigurationErrorViewController(with: errorMessage)
            self.insertChild(sourceViewController, at: 0)
            self.view.addSubview(sourceViewController.view)
            self.view.frame = sourceViewController.view.frame
        })
    }
    
    /// This methods check the context informations consistency based on the defined phase.
    /// - Parameters:
    ///   - completion: return the available phase (the defined one if possible).
    ///   - errorHandler: return an error message if no available phases for the defined informations.
    private func checkContextConsistency(_ completion: @escaping (_ phase: String) -> Void, errorHandler: @escaping (_ errorMessage: String) -> Void) {
        guard let context = Context.main else {
            errorHandler("Impossible to parse configuration file, please contact an administrator.")
            return
        }
        
        func testForPhase0() -> Bool {
            guard let registrationData = context.dataSet.registration, !registrationData.pages.isEmpty else { return false }
            for page in registrationData.pages {
                guard !page.fields.isEmpty else { return false }
            }
            return true
        }
        
        func testForPhase1() -> Bool {
            guard let bundleSelectionData = context.dataSet.bundleSelectionPage,
                !bundleSelectionData.bundles.isEmpty else { return false }
            for bundle in bundleSelectionData.bundles {
                guard !bundle.apps.isEmpty else { return false }
            }
            return true
        }
        
        func testForPhase2() -> Bool {
            guard !context.dataSet.postInstallationPage.items.isEmpty else { return false }
            return true
        }
        
        func testForPhase3() -> Bool {
            return testForPhase0()
        }
        
        func testForPhase4() -> Bool {
            return testForPhase1()
        }
        
        switch context.dataSet.phase {
        case "0":
            guard testForPhase0() else {
                guard testForPhase1() else {
                    guard testForPhase2() else {
                        errorHandler("Impossible to find the information needed, please contact an administrator.")
                        return
                    }
                    context.dataSet.phase = "2"
                    completion(context.dataSet.phase)
                    return
                }
                context.dataSet.phase = "1"
                completion(context.dataSet.phase)
                return
            }
            completion(context.dataSet.phase)
        case "1":
            guard testForPhase1() else {
                guard testForPhase2() else {
                    errorHandler("Impossible to find the information needed, please contact an administrator.")
                    return
                }
                context.dataSet.phase = "2"
                completion(context.dataSet.phase)
                return
            }
            completion(context.dataSet.phase)
        case "2":
            guard testForPhase2() else {
                errorHandler("Impossible to find the information needed, please contact an administrator.")
                return
            }
            completion(context.dataSet.phase)
        case "3":
            guard testForPhase3() else {
                errorHandler("Impossible to find the information needed, please contact an administrator.")
                return
            }
            completion(context.dataSet.phase)
        case "4":
            guard testForPhase4() else {
                errorHandler("Impossible to find the information needed, please contact an administrator.")
                return
            }
            completion(context.dataSet.phase)
        default:
            errorHandler("Impossible to find the information needed, please contact an administrator.")
        }
    }
}
