//
//  String-Extensions.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 2/5/20.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
