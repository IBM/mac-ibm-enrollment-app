//
//  SummaryPageTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class SummaryPageTests: XCTestCase {

    let summaryPageJsonStub = """
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
        "items": [
            {
                "title": "fakeTitle",
                "description": "fakeDescription",
                "alternateDescription": "fakeAlternateDescription",
                "policyOrUrl": "fakePolicy",
                "iconName": "testIconName",
                "ctaType": "testType"
            }

        ]
    }
    """

    func testSummaryPageInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: SummaryPage

        // When
        sut = try decoder.decode(SummaryPage.self, from: summaryPageJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is SummaryPage)
        XCTAssert((sut.subtitle as Any) is InfoLabel)
        XCTAssert((sut.title as Any) is InfoLabel)
        XCTAssert((sut.items as Any) is [SummaryPage.Item])
    }
}
