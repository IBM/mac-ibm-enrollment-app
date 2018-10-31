//
//  IssueAlertService.swift
//  enrollment
//
//  Created by Jay Latman on 10/21/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Cocoa

/**
 Shared service class for extending the displaying of NSAlerts to the enrollment app.
 */
class IssueAlertService: NSObject {
    static let sharedInstance: IssueAlertService = {
        let instance = IssueAlertService()
        return instance
    }()
    
    /**
     Method for displaying an alert sheet with the option to initiate a jamf policy by event trigger via the Jamf Integration Helper binary
     
     - Parameter messageText : string value for the header of the alert
     - Parameter informativeText : string value for the central part of the alert
     - Parameter style : NSAlert.style (critical, informational, warning)
     - Parameter button1 : string value for the cancel button label
     - Parameter button2 : string value for the proceed / action button label
     - Parameter jamfEvent : string value for the jamf event trigger
     - Parameter button1LogText : string value for the logging of the cancel button being used
     */
    func displaySheetWithJAMFAction(header messageText: String?, message informativeText: String?, style: NSAlert.Style, cancelButtonLabel button1: String?, actionButtonLabel button2: String?, jamfPolicyEvent jamfEvent: String?, button1LogText: String?) {
        
        let alert = NSAlert()
        if let message = messageText {
            alert.messageText = message
        }
        
        if let information = informativeText {
            alert.informativeText = information
        }
        
        alert.alertStyle = style
        
        if button1 != nil {
            alert.addButton(withTitle: button1!)
        }
        
        if button2 != nil {
            alert.addButton(withTitle: button2!)
        }
        
        alert.beginSheetModal(for: NSApp.keyWindow!) { (returnCode) -> Void in
            if returnCode == NSApplication.ModalResponse.alertSecondButtonReturn {
                XPCService.sharedInstance.processJAMFAction(event: JAMFPolicyEventID.removeFramework)
                exit(0)
            } else {
                if button1LogText != nil {
                    NSLog("Enrollment User interaction: \(button1LogText!)")
                }
            }
        }
    }
    
    /**
     Method for displaying an alert modal in the event the app can not be launched
     
     - Parameter messageText : string value for the header of the alert
     - Parameter informativeText : string value for the central part of the alert
     - Parameter style : NSAlert.style (critical, informational, warning)
     - Parameter button1 : string value for the cancel button label
    */
    func displayModalFailureToLaunch(header messageText: String?, message informativeText: String?, style: NSAlert.Style, cancelButtonLabel button1: String?) {
        let appLaunchFailure = NSAlert()
        
        appLaunchFailure.alertStyle = style
        
        if let message = messageText {
            appLaunchFailure.messageText = message
        }
        
        if let information = informativeText {
            appLaunchFailure.informativeText = information
        }
        
        if button1 != nil {
            appLaunchFailure.addButton(withTitle: button1!)
        }
        
        appLaunchFailure.runModal()
        NSApp.terminate(self)
    }
    
    /**
     Method for displaying an alert sheet in the event the network is unreachable
     
     - Parameter message : string value for the alert text to be displayed
    */
    func displaySheetNetworkUnreachable(message: String?) {
        let alert = NSAlert()
        if let message = message {
            alert.messageText = message
        }
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK")
        alert.beginSheetModal(for: NSApp.keyWindow!)
    }
}
