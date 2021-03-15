//
//  BundleInstalationPageTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class BundleInstallationPageTests: XCTestCase {
    let bundleInstallationPageJsonStub = """
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
            "bundleInstallationStatus": true
        }
    """

    func testBundleInstallationPageInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: BundleInstallationPage

        // When
        sut = try decoder.decode(BundleInstallationPage.self, from: bundleInstallationPageJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is BundleInstallationPage)
        XCTAssert((sut.title as Any) is InfoLabel)
        XCTAssert((sut.subtitle as Any) is InfoLabel)
    }
}
