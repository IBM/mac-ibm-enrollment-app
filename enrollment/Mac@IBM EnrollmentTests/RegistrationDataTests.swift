//
//  RegistrationDataTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class RegistrationDataTests: XCTestCase {
    let registrationDataJsonStub = """
        {
            "pages": [
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
                    "subtitle": {
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
                    "fields": [
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
                    ],
                    "footer": {
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
                    }
                }
            ],
            "registrationStatus": true
        }
    """

    func testRegistrationDataInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: RegistrationData

        // When
        sut = try decoder.decode(RegistrationData.self, from: registrationDataJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is RegistrationData)
        XCTAssert((sut.pages as Any) is [RegistrationPage])
        XCTAssertNotNil(sut.registrationStatus)
    }
}
