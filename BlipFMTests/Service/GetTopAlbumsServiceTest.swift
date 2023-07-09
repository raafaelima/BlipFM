//
//  GetTopAlbumsServiceTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

final class GetTopAlbumsServiceTest: XCTestCase {

    private var sut: GetTopAlbumsService!
    private var networkProviderMock = URLSessionNetworkProviderMock(jsonSource: "top-albuns")
    private var dataParserMock = JsonDataParserMock(jsonSource: "top-albuns")

    override func setUp() async throws {
        self.sut = GetTopAlbumsService(networkProvider: networkProviderMock, parser: dataParserMock)
    }

    func testTopAlbunsFromAValidDataSource() async throws {
        let albums = try await sut.fetchTopAlbuns(ofGenre: "hipHop").albums
        XCTAssertEqual(albums.count, 2)
        XCTAssertEqual(albums[0].mbid, "cd7d8c81-d519-4149-8cd0-ade722ad19b9")
        XCTAssertEqual(albums[0].name, "My Beautiful Dark Twisted Fantasy")
        XCTAssertEqual(albums[0].artist, "Kanye West")

        XCTAssertEqual(albums[1].mbid, "06a81817-093d-40f0-aef2-90673fa550ae")
        XCTAssertEqual(albums[1].name, "Graduation")
        XCTAssertEqual(albums[1].artist, "Kanye West")
    }

    func testServiceHadMadeTheRequestToTheCorrectSource() async throws {
        _ = try await sut.fetchTopAlbuns(ofGenre: "hipHop")
        XCTAssertEqual(networkProviderMock.didCallRequestData, true)
        XCTAssertEqual(networkProviderMock.endpointRequestURL, "https://localhost.com/?method=tag.gettopalbums&api_key=123apikey321&format=json&tag=hipHop&page=1&limit=60")
    }

    func testThrowServiceErrorWhenThereIsANetworkProblem() async throws {

        let expectation = XCTestExpectation(description: "response")
        networkProviderMock.forceError = true

        do {
            _ = try await sut.fetchTopAlbuns(ofGenre: "Pop")
            XCTFail("Should not have value back")
        } catch {
            let serviceError = error as! ServiceError
            XCTAssertEqual(serviceError, .networkNotReachable)
            expectation.fulfill()
        }
    }

    func testThrowServiceErrorWhenThereIsAParserProblem() async throws {

        let expectation = XCTestExpectation(description: "response")
        dataParserMock.forceError = true

        do {
            _ = try await sut.fetchTopAlbuns(ofGenre: "Pop")
            XCTFail("Should not have value back")
        } catch {
            let serviceError = error as! ServiceError
            XCTAssertEqual(serviceError, .invalidSourceData)
            expectation.fulfill()
        }
    }
}
