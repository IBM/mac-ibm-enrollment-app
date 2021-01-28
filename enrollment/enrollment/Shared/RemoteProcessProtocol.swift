//
//  RemoteProcessProtocol.swift
//  enrollment
//
//  Created by Jay Latman on 7/27/18.
//  Copyright © 2018 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import Foundation

@objc(RemoteProcessProtocol)
protocol RemoteProcessProtocol {
    func runPolicy(event: String, reply: @escaping (String?) -> Void)
    func getVersion(reply: @escaping (String?) -> Void)
}
