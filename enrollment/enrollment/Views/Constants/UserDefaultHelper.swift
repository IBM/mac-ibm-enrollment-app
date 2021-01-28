//
//  UserDefaultHelper.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 2/20/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

struct UserDefaultHelper {
    struct Keys {
        static let phase = "phase"
        static let registrationStatus = "registrationStatus"
        static let hrFirstName = "hrFirstName"
        static let environment = "environment"
        static let selectedBundles = "SelectedBundles"
    }
    
    struct Bundles {
        struct AppInstallScreen {
            static let status = "appScreenStatus"
            static let warning = "appScreenWarning"
        }
        
        struct Connectivity {
            static let messaging = "connectivityMessaging"
            static let status = "connectivityBundleStatus"
            struct AppStatus {
                static let app1 = "anyconnectInstallStatus"
            }
            struct DownloadTime {
                static let size = "connectivitySize"
                static let time = "connectivityInstallSeconds"
            }
        }
        
        struct Essentials {
            static let messaging = "essentialsMessaging"
            static let status = "essentialsBundleStatus"
            struct AppStatus {
                static let app1 = "notesInstallStatus"
                static let app2 = "webexmeetingsInstallStatus"
                static let app3 = "code42InstallStatus"
                static let app4 = "bluepagesInstallStatus"
                static let app5 = "safariBookmarksInstallStatus"
            }
            struct DownloadTime {
                static let size = "essentialsSize"
                static let time = "essentialsInstallSeconds"
            }
        }
        
        struct Productivity {
            static let messaging = "productivityMessaging"
            static let status = "productivityBundleStatus"
            struct AppStatus {
                static let app1 = "officeInstallStatus"
                static let app2 = "slackInstallStatus"
                static let app3 = "boxInstallStatus"
            }
            struct DownloadTime {
                static let size = "productivitySize"
                static let time = "productivityInstallSeconds"
            }
        }
    }
}
