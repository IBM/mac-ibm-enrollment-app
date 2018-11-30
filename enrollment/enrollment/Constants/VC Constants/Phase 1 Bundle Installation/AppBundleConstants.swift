//
//  AppBundleConstants.swift
//  enrollment
//
//  Created by Jay Latman on 9/3/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Structure definition containing the reference assignments of stored values or property list key names for storing and retrieving values.
 
 Child structs :
 
 • Keys - Key names used for storing and retrieving values in processing and displaying app bundles
 
 • PersistanceArrayMember - Bundle array names to be anayalzed by the jamf install event to determine customer choices
 
 • Bundle - Keys and values used for display and updating of UI
 */
struct AppBundlesConstants {
    /**
     - `bundleArrayKey` - key name used for the array of bundle selections made by the customer
     
     - `speedRate` - key name used for the stored value of the download rate in MB / second
     
     - `jamfBufferTime` - key name used for the stored value of the estimated communication buffer time with the jps
     
     - `installClockTotal` - key name used for the stored total download time to be referenced between selection and install views
     
     child struct : AppInstallScreen
     */
    struct Keys {
        static let bundleArrayKey = "SelectedBundles"
        static let speedRate = "speedTestResult"
        static let jamfBufferTime = "jpsCommSeconds"
        static let installClockTotal = "installClockTotal"
        
        /**
         - `status` - key name used for storing the boolean value to set the state of the total install process indicator
         
         - `warning` - key name used for the storing of the boolean value to set the state of visibility for the warning string if the install process encountered a failure
         */
        struct AppInstallScreen {
            static let status = "appScreenStatus"
            static let warning = "appScreenWarning"
        }
    }
    
    /**
     Bundle choice names stored by selection and anaylzed by the jamf policy for installation process
     */
    struct PersistanceArrayMember {
        static let a = "connectivity"
        static let b = "essentials"
        static let c = "productivity"
    }
    
    struct Bundle {
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the first bundle choice displayed on the selection view
         
         child structs :
         
         • Keys - key names used for storing and retrieving values in processing and displaying the bundle
         
         • Infopopover - strings and NSImages to be displayed for the corresponding info popover
         
         • DownloadTime - key anmes used for storing and retrieving values to display and calculate estimated download times
         */
        struct A {
            struct Keys {
                /**
                 Key names for storing and retrieving bundle status
                 
                 `messaging` - key name used for storing and referencing the messaging string for bundle progress
                 
                 `status` - key name used for storing and referencing the integer value determining bundle install status
                 
                 child struct : AppStatus
                 */
                struct Bundle {
                    
                    static let messaging = "connectivityMessaging"
                    static let status = "connectivityBundleStatus"
                    
                    /**
                     Struct containing the key names for storing and referencing the integer value for each app in the bundle to determine install status
                    */
                    struct AppStatus {
                        static let app1 = "connectivityApp1Status"
                    }
                }
            }
            
            /**
             Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the first bundle choice info popover.
             
             • header - string value attributed to the first line of text on the popover
             
             • mainDescription - string value attributed to the description / second line of text on the popover
             
             • titles - [Array] of string values attributed to the individual app titles within the bundle
             
             • icons - [Array] of NSImages provided from the asset catalog for each app title
             
             • descriptions - [Array] of string values attributed to each app title
            */
            struct Infopopover {
                static let header = "Connectivity bundle"
                static let mainDescription = "Get connected to our network with certificates and software"
                static let titles: [String] = [
                    "app1"
                ]
                static let icons : [NSImage] = [
                    #imageLiteral(resourceName: "generic-app-icon")
                ]
                static let descriptions: [String] = [
                    "Ipsum lorem 1"
                ]
            }
            
            /**
             Structure definition containing the key names used for storing and retrieving values realted to the first bundle's install duration
             
             `size` - key name used for the bundle size in megabytes
             
             `time` - key name used for the bundle install time in seconds
             */
            struct DownloadTime {
                static let size = "connectivityBundleSize"
                static let time = "connectivityBundleInstallSeconds"
            }
        }
        
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the second bundle choice displayed on the selection view
         
         child structs :
         
         • Keys - key names used for storing and retrieving values in processing and displaying the bundle
         
         • Infopopover - strings and NSImages to be displayed for the corresponding info popover
         
         • DownloadTime - key anmes used for storing and retrieving values to display and calculate estimated download times
         */
        struct B {
            struct Keys {
                /**
                 Key names for storing and retrieving bundle status
                 
                 `messaging` - key name used for storing and referencing the messaging string for bundle progress
                 
                 `status` - key name used for storing and referencing the integer value determining bundle install status
                 
                 child struct : AppStatus
                 */
                struct Bundle {
                    static let messaging = "essentialsMessaging"
                    static let status = "essentialsBundleStatus"
                    
                    /**
                     Struct containing the key names for storing and referencing the integer value for each app in the bundle to determine install status
                     */
                    struct AppStatus {
                        static let app1 = "essentialsApp1Status"
                        static let app2 = "essentialsApp2Status"
                        static let app3 = "essentialsApp3Status"
                        static let app4 = "essentialsApp4Status"
                    }
                }
            }
            
            /**
             Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the second bundle choice info popover.
             
             • header - string value attributed to the first line of text on the popover
             
             • mainDescription - string value attributed to the description / second line of text on the popover
             
             • titles - [Array] of string values attributed to the individual app titles within the bundle
             
             • icons - [Array] of NSImages provided from the asset catalog for each app title
             
             • descriptions - [Array] of string values attributed to each app title
             */
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
            
            /**
             Structure definition containing the key names used for storing and retrieving values realted to the second bundle's install duration
             
             `size` - key name used for the bundle size in megabytes
             
             `time` - key name used for the bundle install time in seconds
             */
            struct DownloadTime {
                static let size = "essentialsBundleSize"
                static let time = "essentialsBundleInstallSeconds"
            }
        }
        
        /**
         Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the third bundle choice displayed on the selection view
         
         child structs :
         
         • Keys - key names used for storing and retrieving values in processing and displaying the bundle
         
         • Infopopover - strings and NSImages to be displayed for the corresponding info popover
         
         • DownloadTime - key anmes used for storing and retrieving values to display and calculate estimated download times
         */
        struct C {
            struct Keys {
                /**
                 Key names for storing and retrieving bundle status
                 
                 `messaging` - key name used for storing and referencing the messaging string for bundle progress
                 
                 `status` - key name used for storing and referencing the integer value determining bundle install status
                 
                 child struct : AppStatus
                 */
                struct Bundle {
                    static let messaging = "productivityMessaging"
                    static let status = "productivityBundleStatus"
                    
                    /**
                     Struct containing the key names for storing and referencing the integer value for each app in the bundle to determine install status
                     */
                    struct AppStatus {
                        static let app1 = "productivityApp1Status"
                        static let app2 = "productivityApp2Status"
                        static let app3 = "productivityApp3Status"
                    }
                }
            }
            
            /**
             Structure definition containing reference assignments of stored values or property list key names for retrieving values relating to the third bundle choice info popover.
             
             • header - string value attributed to the first line of text on the popover
             
             • mainDescription - string value attributed to the description / second line of text on the popover
             
             • titles - [Array] of string values attributed to the individual app titles within the bundle
             
             • icons - [Array] of NSImages provided from the asset catalog for each app title
             
             • descriptions - [Array] of string values attributed to each app title
             */
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
            
            /**
             Structure definition containing the key names used for storing and retrieving values realted to the third bundle's install duration
             
             `size` - key name used for the bundle size in megabytes
             
             `time` - key name used for the bundle install time in seconds
            */
            struct DownloadTime {
                static let size = "productivityBundleSize"
                static let time = "productivityBundleInstallSeconds"
            }
        }
    }
}
