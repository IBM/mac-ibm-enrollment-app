//
//  EnrollmentDataSetTests.swift
//  Mac@IBM EnrollmentTests
//
//  Created by Jan Valentik on 04/05/2020.
//  Copyright © 2020 IBM. All rights reserved.
//  SPDX-License-Identifier: GPL-3.0-only
//

import XCTest
@testable import Mac_IBM_Enrollment

class EnrollmentDataSetTests: XCTestCase {
    let enrollmentDatatSetJsonStub = """
        {
            "userInfo": {
                "hrFirstName": "johny"
            },
            "networkInfo": {
                "speedTestResult": "speed",
                "jpsCommSeconds": "jps"
            },
            "phase": "phase",
            "selectedBundles": [
                "selectedBundles"
            ],
            "policies": {
                "registrationPolicy": "testPolicy",
                "bundleInstallationPolicy": "test",
                "removeFramework": "test"
            },
            "registration": {
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
            },
            "bundleSelectionPage": {
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
            },
            "bundleInstallationPage": {
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
            },
            "summaryScreen": {
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
            },
            "selectedRegistrationInfo": [
                {
                    "fieldKey": "fieldKey",
                    "fieldTitle": "fieldTitle",
                    "selectedOptionKeys": [
                        "keys"
                    ],
                    "selectedOptionTitles": [
                        "titles"
                    ],
                    "isMultipleChoiseAllowed": true
                }
            ]
        }
    """

    func testEnrollmentDataSetInitializedCorrectly() throws {
        // Given
        let decoder = JSONDecoder()
        var sut: EnrollmentDataSet

        // When
        sut = try decoder.decode(EnrollmentDataSet.self, from: enrollmentDatatSetJsonStub.data(using: .utf8)!)

        // Then
        XCTAssert((sut as Any) is EnrollmentDataSet)
        XCTAssert((sut.userInfo as Any) is EnrollmentDataSet.UserInfo)
        XCTAssert((sut.networkInfo as Any) is EnrollmentDataSet.NetworkInfo)
        XCTAssert((sut.selectedBundles as Any) is [String])
        XCTAssert((sut.bundleInstallationPage as Any) is BundleInstallationPage)
        XCTAssert((sut.bundleSelectionPage as Any) is BundleSelectionPage)
        
    }

}
