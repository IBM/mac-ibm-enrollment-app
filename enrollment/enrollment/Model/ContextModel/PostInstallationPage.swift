//
//  PostInstallationPage.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class PostInstallationPage: Codable {
    
    public struct Item: Codable {
        enum CTAType: String {
            case none
            case url
            case policy
        }
        var title: String
        var description: String
        var iconName: String
        var iconURL: URL?
        var ctaType: CTAType
        var ctaPayload: String?
        
        enum SummaryItemCodingKey: String, CodingKey {
            case title
            case description
            case iconName
            case iconURL
            case alternateDescription
            case ctaType
            case ctaPayload
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: SummaryItemCodingKey.self)
            
            title = try values.decode(String.self, forKey: .title)
            description = try values.decode(String.self, forKey: .description)
            iconName = try values.decode(String.self, forKey: .iconName)
            if let urlString = try values.decodeIfPresent(String.self, forKey: .iconURL) {
                iconURL = URL(string: urlString)
            }
            let ctaPayloadRawValue = try values.decode(String.self, forKey: .ctaType)
            ctaType = CTAType(rawValue: ctaPayloadRawValue) ?? .none
            ctaPayload = try values.decodeIfPresent(String.self, forKey: .ctaPayload)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: SummaryItemCodingKey.self)
            
            try container.encode(title, forKey: .title)
            try container.encode(description, forKey: .description)
            try container.encode(iconName, forKey: .iconName)
            try container.encodeIfPresent(iconURL?.absoluteString, forKey: .iconURL)
            try container.encode(ctaType.rawValue, forKey: .ctaType)
            try container.encodeIfPresent(ctaPayload, forKey: .ctaPayload)
        }
    }
    
    var title: InfoLabel
    var subtitle: InfoLabel?
    var items: [Item]
    var needsRestart: Bool?
    var restartTimeout: Int?
    
    init(_ title: InfoLabel, subtitle: InfoLabel? = nil, items: [Item], needsRestart: Bool? = false, restartTimeout: Int? = 300) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
        self.needsRestart = needsRestart
        self.restartTimeout = restartTimeout
    }
}
