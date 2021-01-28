//
//  Context.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 2/18/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import MoreCodable
import os.log

class Context {
    
    static var main = Context()
    var dataSet: EnrollmentDataSet!
    
    init?() {
        do {
            let decoder = DictionaryDecoder()
            dataSet = try decoder.decode(EnrollmentDataSet.self, from: UserDefaults.standard.dictionaryRepresentation())
        } catch {
            os_log("Decoding error during context creation. Error: %@", error.localizedDescription)
            return nil
        }
    }
    
    func receivedNewStatus(for key: String, newStatus: EnrollmentBundle.InstallationStatus) {
        guard dataSet != nil else { return }
        
        for bundle in dataSet.bundleSelectionPage?.bundles ?? [] {
            if bundle.key == key {
                bundle.status = newStatus
                NotificationCenter.default.post(name: Constants.NewStatusReceivedNotification, object: nil, userInfo: ["key": key, "newStatus": newStatus])
                return
            } else {
                for app in bundle.apps where app.key == key {
                    var newAppInstances = app
                    newAppInstances.status = newStatus
                    bundle.apps.remove(at: bundle.apps.firstIndex(where: { $0.key == key })!)
                    bundle.apps.append(newAppInstances)
                    NotificationCenter.default.post(name: Constants.NewStatusReceivedNotification, object: nil, userInfo: ["key": key, "newStatus": newStatus])
                    return
                }
            }
        }
    }
    
    func receivedNewMessage(for key: String, newMessage: String) {
        guard dataSet != nil else { return }
        
        for bundle in dataSet.bundleSelectionPage?.bundles ?? [] where bundle.key == key {
            bundle.bundleMessaging = newMessage
            NotificationCenter.default.post(name: Constants.NewMessageReceivedNotification, object: nil, userInfo: ["key": key, "newMessage": newMessage])
            return
        }
    }
}
