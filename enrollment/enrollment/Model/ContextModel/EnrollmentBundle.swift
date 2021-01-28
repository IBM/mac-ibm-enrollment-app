//
//  EnrollmentBundle.swift
//  enrollment
//
//  Created by Simone Martorelli on 2/17/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

public final class EnrollmentBundle: Codable {
    public struct App: Codable {
        var title: String
        var description: String
        var key: String
        var status: InstallationStatus
        var icon: String
    }
    
    public enum InstallationStatus: Int, Codable {
        case installationPending = 0
        case installationInProgress = 1
        case installed = 2
        case errorDuringInstallation = 3
        case unknown = -1
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(Int.self)
            self = InstallationStatus(rawValue: rawValue) ?? .unknown
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .installationPending:
                try container.encode(0)
            case .installationInProgress:
                try container.encode(1)
            case .installed:
                try container.encode(2)
            case .errorDuringInstallation:
                try container.encode(3)
            default:
                try container.encode(-1)
            }
        }
    }
    
    var title: String
    var extendedTitle: String
    var description: String
    var key: String
    var icon: String
    var status: InstallationStatus
    var bundleMessaging: String? 
    var time: String?
    var size: String?
    var recommended: Bool
    var apps: [App]
    
    init(_ title: String,
         extendedTitle: String,
         description: String,
         key: String,
         icon: String,
         status: InstallationStatus,
         warningMessage: String? = nil,
         time: String? = nil,
         size: String? = nil,
         recommended: Bool,
         apps: [App]) {
        self.title = title
        self.extendedTitle = extendedTitle
        self.description = description
        self.key = key
        self.icon = icon
        self.status = status
        self.bundleMessaging = warningMessage
        self.time = time
        self.size = size
        self.recommended = recommended
        self.apps = apps
    }
}

extension EnrollmentBundle: Equatable {
    public static func == (lhs: EnrollmentBundle, rhs: EnrollmentBundle) -> Bool {
        return lhs.key == rhs.key
    }
}
