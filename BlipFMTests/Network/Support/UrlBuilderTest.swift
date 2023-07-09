//
//  UrlBuilderTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 07/07/2023.

//

import XCTest
@testable import BlipFM

class UrlBuilderTest: XCTestCase {

    var sut: URLBuilder!

    override func setUp() {
        super.setUp()
        sut = URLBuilder()
    }

    func testVerifyURLParamsBuilder() throws {
        let dummyItem = URLQueryItem(name: "dummy", value: "thisIsADummyParam")
        let url = try sut.build(with: [dummyItem])
        XCTAssertTrue(url.query!.contains("dummy=thisIsADummyParam"))
    }
}
