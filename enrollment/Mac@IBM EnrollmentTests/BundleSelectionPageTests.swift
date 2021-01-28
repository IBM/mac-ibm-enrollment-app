//
//  BundleSelectionPageTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class BundleSelectionPageTests: XCTestCase {
    let bundleSelectionPageJsonStub = """
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
            "bundles": [
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
            ]
        }
    """

    func testBundleSelectionPageInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: BundleSelectionPage

        // When
        sut = try decoder.decode(BundleSelectionPage.self, from: bundleSelectionPageJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is BundleSelectionPage)
        XCTAssert((sut.title as Any) is InfoLabel)
        XCTAssert((sut.subtitle as Any) is InfoLabel)
        XCTAssert((sut.bundles as Any) is [EnrollmentBundle])
    }
}
