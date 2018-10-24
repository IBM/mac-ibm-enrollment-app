//
//  WebLinkButtons.swift
//  enrollment
//
//  Created by Jay Latman on 8/15/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation
import Cocoa

struct WebLinkButtons {
    struct SelfService {
        static let header = "Install apps with Self Service"
        static let description = "Great software for productivity, collaboration, creativity, and more."
        static let url = "selfservice://"
    }
    
    struct Migration {
        static let header = "Migrate your data from another computer"
        static let description = "Transfer important information to your new Mac."
        static let url = "https://support.apple.com/en-us/HT204087"
    }
    
    struct Backup {
        static let header = ""
        static let description = ""
        static let url = ""
    }
    
    struct Help {
        static let header = ""
        static let description = ""
        static let url = ""
    }
}
