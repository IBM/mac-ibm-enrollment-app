//
//  RegistrationChoiceTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class RegistrationChoiceTests: XCTestCase {

    func testRegistrationChoiceInitializedCorrectly() {
        // Given

        // When
        let registrationPage = RegistrationChoice("fieldKey", fieldTitle: "fieldTitle",
                                                  selectedOptionKeys: ["filedKey"],
                                                  selectedOptionTitles: ["fieldTitle"])

        // Then
        XCTAssertNotNil(registrationPage)
    }

}
