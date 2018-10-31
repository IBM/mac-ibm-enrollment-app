//
//  NetworkValidationService.swift
//  enrollment
//
//  Created by Jay Latman on 10/21/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import AppKit
import SystemConfiguration

/**
 Shared service class for extending network validation to the enrollment app
*/
class NetworkValidationService: NSObject {
    
    static let sharedInstance: NetworkValidationService = {
        let instance = NetworkValidationService()
        return instance
    }()
    
    /**
     Method for validating if the system is connected to the internet
    */
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
    
    /**
     Method for validating if the system is able to reach an internal url / intranet
     
     - Parameter urlPath : string value containing the internal testing url
    */
    func verifyInternalURL(urlPath: String, completion: @escaping (_ isValid: Bool)->()) {
        if let url = NSURL(string: urlPath) {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "HEAD"
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (_, response, error) in
                if let httpResponse = response as? HTTPURLResponse, error == nil && httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                    self.displayInternalNetworkValidationWarning()
                }
            }
            task.resume()
        } else {
            completion(false)
        }
    }
    
    /**
     Method for validating if the system is able to reach the Jamf Pro Server
     
     - Parameter jpsURL : string value containing the health check url for the Jamf Pro Server
    */
    func checkForJPSAvailability(jpsURL: String, completion: @escaping (_ result: Int) -> Void) {
        let url = URL(string: jpsURL)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let responseCode = httpResponse.statusCode
                
                completion(responseCode)
            }
        }
        task.resume()
    }
    
    /**
     Private method for displaying an alert sheet in the event the network validation returns a false state
    */
    private func displayInternalNetworkValidationWarning() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.alertStyle = .critical
            alert.messageText = AlertText.NetworkValidationMessaging.Internal.warning
            alert.addButton(withTitle: "OK")
            alert.beginSheetModal(for: NSApp.keyWindow!)
        }
    }
}
