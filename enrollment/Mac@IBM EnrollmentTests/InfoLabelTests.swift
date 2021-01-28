//
//  InfoLabelTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 03/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class InfoLabelTests: XCTestCase {
    let infoLabelJsonStub = """
    {
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
    """

    func testInfoLabelDeserializedCorrectly() throws {

        // Given
        let decoder = JSONDecoder()
        var sut: InfoLabel

        // When
        sut = try decoder.decode(InfoLabel.self, from: infoLabelJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is InfoLabel)
        XCTAssert((sut.infoSection as Any) is InfoSection)
    }

    func disabledTestInfoLabelSerializedCorrectly() throws {

        // Given
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        var sut: InfoLabel

        // When
        sut = try decoder.decode(InfoLabel.self, from: infoLabelJsonStub.data(using: .utf8)!)
        let data = try encoder.encode(sut)
        let jsonString = String(data: data, encoding: .utf8)

        // Then
        XCTAssertTrue(jsonString!.contains(infoLabelJsonStub))
    }
}
