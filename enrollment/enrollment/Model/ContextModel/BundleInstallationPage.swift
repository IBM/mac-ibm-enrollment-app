//
//  BundleInstallationPage.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class BundleInstallationPage: Codable {
    var title: InfoLabel
    var subtitle: InfoLabel?
    var bundleInstallationStatus: Bool
    var bundleInstallationWarning: Bool 
    
    init(_ title: InfoLabel, subtitle: InfoLabel? = nil, bundleInstallationStatus: Bool, bundleInstallationWarning: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.bundleInstallationStatus = bundleInstallationStatus
        self.bundleInstallationWarning = bundleInstallationWarning
    }
    
    enum BundleInstallationPageCodingKeys: String, CodingKey {
        case title
        case subtitle
        case bundleInstallationStatus
        case bundleInstallationWarning
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: BundleInstallationPageCodingKeys.self)
        
        title = try values.decode(InfoLabel.self, forKey: .title)
        subtitle = try values.decodeIfPresent(InfoLabel.self, forKey: .subtitle)
        bundleInstallationStatus = try values.decodeIfPresent(Bool.self, forKey: .bundleInstallationStatus) ?? false
        bundleInstallationWarning = try values.decodeIfPresent(Bool.self, forKey: .bundleInstallationWarning) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BundleInstallationPageCodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(bundleInstallationStatus, forKey: .bundleInstallationStatus)
        try container.encode(bundleInstallationWarning, forKey: .bundleInstallationWarning)
    }
    
}
