//
//  GetAlbumDetailServiceTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

final class GetAlbumDetailServiceTest: XCTestCase {

    private var sut: GetAlbumDetailService!
    private var networkProviderMock = URLSessionNetworkProviderMock(jsonSource: "album-detail")
    private var dataParserMock = JsonDataParserMock(jsonSource: "album-detail")

    override func setUp() async throws {
        self.sut = GetAlbumDetailService(networkProvider: networkProviderMock, parser: dataParserMock)
    }

    func testTopAlbunsFromAValidDataSource() async throws {
        let details = try await sut.fetchDetails(of: Album(mbid: "", name: "", artist: "", images: [])).album
        XCTAssertEqual(details.name, "Graduation")
        XCTAssertEqual(details.artist, "Kanye West")
        XCTAssertEqual(details.tracks.count, 13)
        XCTAssertEqual(details.listeners, 2507444)
        XCTAssertEqual(details.playcount, 91181415)
    }

    func testServiceHadMadeTheRequestToTheCorrectSourceWithMBID() async throws {
        _ = try await sut.fetchDetails(of: Album(mbid: "123456", name: "", artist: "", images: []))
        XCTAssertEqual(networkProviderMock.didCallRequestData, true)
        XCTAssertEqual(networkProviderMock.endpointRequestURL, "https://localhost.com/?method=album.getinfo&api_key=123apikey321&format=json&mbid=123456")
    }

    func testServiceHadMadeTheRequestToTheCorrectSourceWithArtistAndName() async throws {
        _ = try await sut.fetchDetails(of: Album(mbid: "", name: "Graduation", artist: "Kanye West", images: []))
        XCTAssertEqual(networkProviderMock.didCallRequestData, true)
        XCTAssertEqual(networkProviderMock.endpointRequestURL, "https://localhost.com/?method=album.getinfo&api_key=123apikey321&format=json&artist=Kanye%20West&album=Graduation")
    }

    func testThrowServiceErrorWhenThereIsANetworkProblem() async throws {

        let expectation = XCTestExpectation(description: "response")
        networkProviderMock.forceError = true

        do {
            _ = try await sut.fetchDetails(of: Album(mbid: "", name: "", artist: "", images: []))
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
            _ = try await sut.fetchDetails(of: Album(mbid: "", name: "", artist: "", images: []))
            XCTFail("Should not have value back")
        } catch {
            let serviceError = error as! ServiceError
            XCTAssertEqual(serviceError, .invalidSourceData)
            expectation.fulfill()
        }
    }
}
