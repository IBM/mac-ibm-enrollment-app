//
//  InfoLabel.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public struct InfoField: Codable {
    var label: String
    var description: String?
    var iconName: String?
}

public struct InfoSection: Codable {
    var fields: [InfoField]
}

public final class InfoLabel: Codable, Equatable {
    var label: String
    var attributedLabel: NSAttributedString? // Convenience variables not present in the .plist
    var infoSection: InfoSection?
    
    init(_ label: String, alternateLabel: String? = nil, attributedLabel: NSAttributedString? = nil, attributedAlternateLabel: NSAttributedString? = nil, withHelpSection help: InfoSection? = nil) {
        self.label = label
        self.attributedLabel = attributedLabel
        self.infoSection = help
    }
    
    public static func == (lhs: InfoLabel, rhs: InfoLabel) -> Bool {
        return lhs.label == rhs.label
    }
    
    enum InfoLabelCodingKeys: String, CodingKey {
        case label
        case alternateLabel
        case infoSection
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: InfoLabelCodingKeys.self)
        
        label = try values.decode(String.self, forKey: .label)
        infoSection = try values.decodeIfPresent(InfoSection.self, forKey: .infoSection)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: InfoLabelCodingKeys.self)
        
        try container.encode(label, forKey: .label)
        try container.encodeIfPresent(infoSection, forKey: .infoSection)
    }

}
