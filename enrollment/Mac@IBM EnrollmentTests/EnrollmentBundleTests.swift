//
//  EnrollmentBundleTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class EnrollmentBundleTests: XCTestCase {
    let enrollmentBundleJsonStub = """
        {
            "title": "testTitle",
            "extendedTitle": "testExtendedTitle",
            "description": "testDescription",
            "key": "testKey",
            "icon": "testIcon",
            "status": -1,
            "warningMessage": "testWarningMessage",
            "time": "testTime",
            "size": "testSize",
            "recommended": true,
            "apps": [
                {
                    "title": "appTitle",
                    "description": "appDescription",
                    "key": "appKey",
                    "status": -1,
                    "icon": "appIcon"
                }
            ]
        }
    """

    func testEnrollmentBundleInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: EnrollmentBundle

        // When
        sut = try decoder.decode(EnrollmentBundle.self, from: enrollmentBundleJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is EnrollmentBundle)
        XCTAssert((sut.apps as Any) is [EnrollmentBundle.App])
    }
}
