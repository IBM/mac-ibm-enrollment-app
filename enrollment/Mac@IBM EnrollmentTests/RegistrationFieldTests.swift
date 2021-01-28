//
//  RegistrationFieldTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class RegistrationFieldTests: XCTestCase {
    let registrationFieldJsonStub = """
    {
       "title": {
            "label": "testLabel",
            "alternateLabel": "testAlternateLabel",
            "infoSection": {
                "fields": [
                    {
                    "label": "testLabel",
                    "description": "testDescription",
                    "iconName": "testIconName"
                    }
                ]
            }
        },
        "key": "fakeKey",
        "multipleChoiseAllowed": true,
        "showTitle": true,
        "options": [
            {
                "key": "optionKey",
                "label": "optionLabel",
                "isExclusive": true
            }
        ]
    }
    """
    
    func testRegistrationFieldInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: RegistrationField

        // When
        sut = try decoder.decode(RegistrationField.self, from: registrationFieldJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is RegistrationField)
        XCTAssert((sut.options as Any) is [RegistrationField.Option])
    }

}
