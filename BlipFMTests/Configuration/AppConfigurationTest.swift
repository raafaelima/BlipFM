//
//  AppConfigurationTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

final class AppConfigurationTest: XCTestCase {

    func testHostIsFilled() throws {
        let host = AppConfiguration.shared.host
        XCTAssertEqual(host, "https://localhost.com/")
    }

    func testApiKeyIsFilled() throws {
        let apiKey = AppConfiguration.shared.apiKey
        XCTAssertEqual(apiKey, "123apikey321")
    }

    func testContentTypeIsFilled() throws {
        let contentType = AppConfiguration.shared.contentType
        XCTAssertEqual(contentType, "application/json")
    }

    func testRequestTypeIsFilled() throws {
        let contentType = AppConfiguration.shared.requestType
        XCTAssertEqual(contentType, "json")
    }
}
