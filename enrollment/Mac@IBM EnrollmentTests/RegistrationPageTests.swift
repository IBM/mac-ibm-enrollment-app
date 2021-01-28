//
//  RegistrationPageTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class RegistrationPageTests: XCTestCase {

    let registrationPageJsonStub = """
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
    """

    func testRegistrationPageInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: RegistrationPage

        // When
        sut = try decoder.decode(RegistrationPage.self, from: registrationPageJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is RegistrationPage)
        XCTAssert((sut.title as Any) is InfoLabel)
        XCTAssert((sut.subtitle as Any) is InfoLabel)
        XCTAssert((sut.fields as Any) is [RegistrationField])
        XCTAssert((sut.footer as Any) is InfoLabel)        
    }
}
