//
//  PostRegistrationPage.swift
//  Mac@IBM Enrollment
//
//  Created by Simone Martorelli on 16/12/2020.
//  Copyright © 2020 IBM. All rights reserved.
//

import Foundation

final class PostRegistrationPage: Codable {
    var title: InfoLabel
    var subtitle: InfoLabel?
    var body: String
    var needsRestart: Bool?
    var restartTimeout: Int?
    var footer: InfoLabel?
}
