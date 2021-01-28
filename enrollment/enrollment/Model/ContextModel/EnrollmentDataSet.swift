//
//  EnrollmentDataSet.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public class EnrollmentDataSet: Codable {
    struct UserInfo: Codable {
        var hrFirstName: String?
    }
    
    struct NetworkInfo: Codable {
        var speedTestResult: String?
        var jpsCommSeconds: String?
    }
    
    var phase: String {
        didSet {
            UserDefaults.standard.set(phase, forKey: UserDefaultHelper.Keys.phase)
        }
    }
    var userInfo: UserInfo
    var networkInfo: NetworkInfo?
    var selectedBundles: [String] {
        didSet {
            UserDefaults.standard.set(selectedBundles, forKey: UserDefaultHelper.Keys.selectedBundles)
        }
    }
    var selectedRegistrationInfo: [RegistrationChoice] {
        didSet {
            for info in selectedRegistrationInfo {
                if !info.isMultipleChoiseAllowed {
                    UserDefaults.standard.set(info.selectedOptionKeys.first!, forKey: info.fieldKey)
                } else {
                    UserDefaults.standard.set(info.selectedOptionKeys, forKey: info.fieldKey)
                }
            }
        }
    }
    var policies: JamfPoliciesStore
    var registration: RegistrationData?
    var bundleSelectionPage: BundleSelectionPage?
    var bundleInstallationPage: BundleInstallationPage?
    var postRegistrationPage: PostRegistrationPage
    var postInstallationPage: PostInstallationPage
    var environment: String?
    
    init(_ phase: String,
         userInfo: UserInfo,
         networkInfo: NetworkInfo? = nil,
         selectedBundles: [String] = [],
         selectedRegistrationInfo: [RegistrationChoice] = [],
         policies: JamfPoliciesStore,
         registration: RegistrationData? = nil,
         bundleSelectionPage: BundleSelectionPage? = nil,
         bundleInstallationPage: BundleInstallationPage? = nil,
         postInstallationPage: PostInstallationPage,
         postRegistrationPage: PostRegistrationPage,
         environment: String) {
        self.phase = phase
        self.userInfo = userInfo
        self.networkInfo = networkInfo
        self.selectedBundles = selectedBundles
        self.selectedRegistrationInfo = selectedRegistrationInfo
        self.policies = policies
        self.registration = registration
        self.bundleSelectionPage = bundleSelectionPage
        self.bundleInstallationPage = bundleInstallationPage
        self.postInstallationPage = postInstallationPage
        self.postRegistrationPage = postRegistrationPage
        self.environment = environment
    }
    
    enum EnrollmentDataSetCodingKey: String, CodingKey {
        case phase
        case userInfo
        case networkInfo
        case selectedBundles
        case selectedRegistrationInfo
        case policies
        case registration
        case bundleSelectionPage
        case bundleInstallationPage
        case postInstallationPage
        case postRegistrationPage
        case environment
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnrollmentDataSetCodingKey.self)
        
        phase = try values.decode(String.self, forKey: .phase)
        userInfo = try values.decode(UserInfo.self, forKey: .userInfo)
        networkInfo = try values.decodeIfPresent(NetworkInfo.self, forKey: .networkInfo)
        selectedBundles = try values.decodeIfPresent([String].self, forKey: .selectedBundles) ?? []
        selectedRegistrationInfo = try values.decodeIfPresent([RegistrationChoice].self, forKey: .selectedRegistrationInfo) ?? []
        policies = try values.decode(JamfPoliciesStore.self, forKey: .policies)
        registration = try values.decodeIfPresent(RegistrationData.self, forKey: .registration)
        bundleSelectionPage = try values.decodeIfPresent(BundleSelectionPage.self, forKey: .bundleSelectionPage)
        bundleInstallationPage = try values.decodeIfPresent(BundleInstallationPage.self, forKey: .bundleInstallationPage)
        postRegistrationPage = try values.decode(PostRegistrationPage.self, forKey: .postRegistrationPage)
        postInstallationPage = try values.decode(PostInstallationPage.self, forKey: .postInstallationPage)
        environment = try values.decodeIfPresent(String.self, forKey: .environment)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnrollmentDataSetCodingKey.self)
        
        try container.encode(phase, forKey: .phase)
        try container.encodeIfPresent(userInfo, forKey: .userInfo)
        try container.encodeIfPresent(networkInfo, forKey: .networkInfo)
        try container.encode(selectedBundles, forKey: .selectedBundles)
        try container.encodeIfPresent(selectedRegistrationInfo, forKey: .selectedRegistrationInfo)
        try container.encodeIfPresent(policies, forKey: .policies)
        try container.encode(registration, forKey: .registration)
        try container.encodeIfPresent(bundleSelectionPage, forKey: .bundleSelectionPage)
        try container.encodeIfPresent(bundleInstallationPage, forKey: .bundleInstallationPage)
        try container.encodeIfPresent(postRegistrationPage, forKey: .postRegistrationPage)
        try container.encodeIfPresent(postInstallationPage, forKey: .postInstallationPage)
        try container.encodeIfPresent(environment, forKey: .environment)
    }
}
