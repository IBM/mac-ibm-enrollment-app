//
//  JAMFConstants.swift
//  enrollment
//
//  Created by Simone Martorelli on 12/10/20.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//
//  swiftlint:disable identifier_name

import Foundation

struct JPSPaths {
    static let binaryPath = "/usr/local/jamf/bin/jamf"
}

enum Environment: String {
    case eng
    case qa
    case prod
    
    static var current: Environment {
        return Environment(rawValue: Context.main?.dataSet.environment ?? "prod") ?? .prod
    }
    var healthCheckURL: String {
        switch self {
        case .eng:
            return ""
        case .qa:
            return ""
        case .prod:
            return ""
        }
    }
}
