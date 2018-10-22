//
//  AppBundleConstants.swift
//  enrollment
//
//  Created by Jay Latman on 9/3/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Cocoa

struct AppBundles {
    static let bundleArrayKey = "SelectedBundles"
    static let speedRate = "speedTestResult"
    static let jamfBufferTime = "jpsCommSeconds"
    static let installClockTotal = "installClockTotal"
    
    struct PersistanceArrayMember {
        static let a = "connectivity"
        static let b = "essentials"
        static let c = "productivity"
    }
    
    struct Bundle {
        struct A {
            struct Keys {
                struct Bundle {
                    static let messaging = "connectivityMessaging"
                    static let status = "connectivityBundleStatus"
                    struct AppStatus {
                        static let app1 = "connectivityApp1Status"
                    }
                }
            }
            struct Infopopover {
                static let header = "Connectivity bundle"
                static let mainDescription = "Get connected to our network with certificates and software"
                static let titles: [String] = [
                    "app1"
                ]
            }
            struct DownloadTime {
                static let size = "connectivityBundleSize"
                static let time = "connectivityBundleInstallSeconds"
            }
        }
        
        struct B {
            struct Keys {
                struct Bundle {
                    static let messaging = "essentialsMessaging"
                    static let status = "essentialsBundleStatus"
                    struct AppStatus {
                        static let app1 = "essentialsApp1Status"
                        static let app2 = "essentialsApp2Status"
                        static let app3 = "essentialsApp3Status"
                        static let app4 = "essentialsApp4Status"
                    }
                }
            }
            struct InfoPopover {
                static let header = "Essentials bundle"
                static let mainDescription = "The apps used by most employees"
                static let titles: [String] = [
                    "app1",
                    "app2",
                    "app3",
                    "app4"
                ]
                static let icons: [NSImage] = [
                    #imageLiteral(resourceName: "generic-app-icon"),
                    #imageLiteral(resourceName: "generic-app-icon"),
                    #imageLiteral(resourceName: "generic-app-icon"),
                    #imageLiteral(resourceName: "generic-app-icon")
                ]
                static let descriptions: [String] = [
                    "Ipsum lorem 1",
                    "Ipsum lorem 2",
                    "Ipsum lorem 3",
                    "Ipsum lorem 4"
                ]
            }
            struct DownloadTime {
                static let size = "essentialsBundleSize"
                static let time = "essentialsBundleInstallSeconds"
            }
        }
        
        struct C {
            struct Keys {
                struct Bundle {
                    static let messaging = "productivityMessaging"
                    static let status = "productivityBundleStatus"
                    struct AppStatus {
                        static let app1 = "productivityApp1Status"
                        static let app2 = "productivityApp2Status"
                        static let app3 = "productivityApp3Status"
                    }
                }
            }
            struct InfoPopover {
                static let header = "Productivity bundle"
                static let mainDescription = "Tools to help you create and collaborate."
                static let titles: [String] = [
                    "app1",
                    "app2",
                    "app3"
                ]
                static let icons: [NSImage] = [
                    #imageLiteral(resourceName: "generic-app-icon"),
                    #imageLiteral(resourceName: "generic-app-icon"),
                    #imageLiteral(resourceName: "generic-app-icon")
                ]
                static let descriptions: [String] = [
                    "Ipsum lorem 1",
                    "Ipsum lorem 2",
                    "Ipsum lorem 3"
                ]
            }
            struct DownloadTime {
                static let size = "productivityBundleSize"
                static let time = "productivityBundleInstallSeconds"
            }
        }
        
        struct AppInstallScreen {
            static let status = "appScreenStatus"
            static let warning = "appScreenWarning"
        }
    }
}
