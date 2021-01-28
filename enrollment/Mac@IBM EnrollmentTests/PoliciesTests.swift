//
//  PoliciesTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class PoliciesTests: XCTestCase {
    let policiesJsonStub = """
        {
            "registrationPolicy": "testPolicy",
            "bundleInstallationPolicy": "test",
            "removeFramework": "test"
        }
    """

    func testPoliciesInitializedCorrectly() {
        // Given

        // When
        let policies = JamfPoliciesStore("fakePolicy", bundleInstallationPolicy: "fakeBundlePolicy", removeFramework: "remove")

        // Then
        XCTAssertNotNil(policies)
    }

    func testPoliciesDeserializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: JamfPoliciesStore

        // When
        sut = try decoder.decode(JamfPoliciesStore.self, from: policiesJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is JamfPoliciesStore)
        
    }

}
