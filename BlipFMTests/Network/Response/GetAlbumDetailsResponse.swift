//
//  GetAlbumDetailsResponseTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

class GetAlbumDetailsResponseTest: XCTestCase {

    var sut: AlbumDetailResponse!

    override func setUp() {
        super.setUp()
        sut = JSONHelper.getObjectFrom(json: "album-detail", type: AlbumDetailResponse.self)!
    }

    func testAlbumDetailsHasTheCorrectDataWhenDecoded() throws {
        let albumDetails = sut.album
        XCTAssertEqual(albumDetails.artist, "Kanye West")
        XCTAssertEqual(albumDetails.tracks.count, 13)
        XCTAssertEqual(albumDetails.listeners, 2507444)
        XCTAssertEqual(albumDetails.playcount, 91181415)
        XCTAssertTrue(albumDetails.summary.contains("Graduation is the third studio album by American rapper Kanye West"))
    }
}
