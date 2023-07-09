//
//  GetTopAlbunsResponseTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

class GetTopAlbunsResponseTest: XCTestCase {

    var sut: AlbumResponse!

    override func setUp() {
        super.setUp()
        sut = JSONHelper.getObjectFrom(json: "top-albuns", type: AlbumResponse.self)!
    }

    func testAlbumsHasTheCorrectSize() throws {
        XCTAssertEqual(sut.albums.count, 2)
    }

    func testAlbumHasTheCorrectDataWhenDecoded() throws {
        let album = sut.albums.first
        XCTAssertNotNil(album)
        XCTAssertEqual(album?.id, "cd7d8c81-d519-4149-8cd0-ade722ad19b9")
        XCTAssertEqual(album?.name, "My Beautiful Dark Twisted Fantasy")
        XCTAssertEqual(album?.artist, "Kanye West")
        XCTAssertEqual(album?.images.count, 4)
    }
}
