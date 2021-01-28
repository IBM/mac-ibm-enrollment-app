//
//  AppleInterfaceStyleMonitor.swift
//  Mac@IBM Enrollment
//
//  Created by Jay on 12/5/18.
//  Copyright © 2018 IBM. All rights reserved.
//

//import Foundation
import AppKit

extension NSViewController {
    enum InterfaceStyle: String {
        case dark = "Dark"
        case light = "Light"
        
        init() {
            let type = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") ?? "Light"
            self = InterfaceStyle(rawValue: type)!
        }
    }
    
    func currentInterfaceStyle() -> InterfaceStyle {
        return InterfaceStyle()
    }
}
