//
//  NetworkValidationService.swift
//  enrollment
//
//  Created by Jay Latman on 10/21/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import AppKit
import SystemConfiguration

class NetworkValidationService: NSObject {
    
    static let sharedInstance: NetworkValidationService = {
        let instance = NetworkValidationService()
        return instance
    }()
    
    
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
    
    func checkForJSSAvailability(jssURL: String, completion: @escaping (_ result: Int) -> Void) {
        let url = URL(string: jssURL)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let responseCode = httpResponse.statusCode
                
                completion(responseCode)
            }
        }
        task.resume()
    }
    
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
