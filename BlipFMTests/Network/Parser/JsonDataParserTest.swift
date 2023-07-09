//
//  JsonDataParserTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 08/06/2023.
//

import Foundation
import XCTest
@testable import BlipFM

class JsonDataParserTest: XCTestCase {

    private var sut: JsonDataParser!

    override func setUp() {
        super.setUp()
        sut = JsonDataParser()
    }

    func testShouldReturnDataParsingErrorWhenDataIsEmpty() throws {

        let expectation = XCTestExpectation(description: "response")

        let mockData = "".data(using: .utf8)

        do {
            let _: String = try sut.process(data: mockData!)
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testShouldReturnDataParsingErrorWhenDataIsWrong() throws {

        let expectation = XCTestExpectation(description: "response")

        let mockData = "[{\"dummy\":\"dummy\"}]".data(using: .utf8)

        do {
            let _: DummyCodable = try sut.process(data: mockData!)
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testShouldReturnValidDataWhenServerRespondAValidJson() throws {

        let expectation = XCTestExpectation(description: "response")

        let mockData = "{\"mock\": 123}".data(using: .utf8)

        do {
            let response: DummyCodable = try sut.process(data: mockData!)
            XCTAssertEqual(response.mock, 123)
            expectation.fulfill()
        } catch {
            XCTFail("expectation not fullfilled")
        }

        wait(for: [expectation], timeout: 1)
    }
}

struct DummyCodable: Codable {
    let mock: Double
}
