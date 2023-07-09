//
//  URLSessionNetworkProviderTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation
import XCTest
@testable import BlipFM

class URLSessionNetworkProviderTest: XCTestCase {

    private var sut: NetworkProvider!
    private var mockSession: URLSession!
    private let endpoint: Endpoint = DummyEndpoint()

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        mockSession = URLSession(configuration: configuration)
        sut = URLSessionNetworkProvider(session: mockSession)
    }

    func testShouldReturnValidData() async throws {

        URLProtocolMock.requestHandler = { _ in
            return (HTTPURLResponse(), Data())
        }

        do {
            let response = try await sut.requestData(from: endpoint)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("expectation not fullfilled")
        }
    }

    func testShouldRaiseNetworkErrorWhenTheresBadRequest() async throws {

        let expectation = XCTestExpectation(description: "response")

        URLProtocolMock.requestHandler = { request in
            let apiURL = URL(string: "https://localhost:8080/lastfm/dummy/path")!
            let response = HTTPURLResponse(url: apiURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await sut.requestData(from: endpoint)
        } catch {
            XCTAssertEqual(error as! NetworkError, .badRequest)
            expectation.fulfill()
        }
    }

    func testShouldRaiseNetworkErrorWhenTheresAInternalServerError() async throws {

        let expectation = XCTestExpectation(description: "response")

        URLProtocolMock.requestHandler = { request in
            let apiURL = URL(string: "https://localhost:8080/lastfm/dummy/path")!
            let response = HTTPURLResponse(url: apiURL, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await sut.requestData(from: endpoint)
        } catch {
            print(error.localizedDescription)
            XCTAssertEqual(error as! NetworkError, .internalServerError)
            expectation.fulfill()
        }
    }

    func testShouldRaiseNetworkErrorWhenTheresAUnauthorizedError() async throws {

        let expectation = XCTestExpectation(description: "response")

        URLProtocolMock.requestHandler = { request in
            let apiURL = URL(string: "https://localhost:8080/lastfm/dummy/path")!
            let response = HTTPURLResponse(url: apiURL, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await sut.requestData(from: endpoint)
        } catch {
            XCTAssertEqual(error as! NetworkError, .unauthorized)
            expectation.fulfill()
        }
    }

    func testShouldRaiseNetworkErrorWithCodeWhenTheresAUntrackedError() async throws {

        let expectation = XCTestExpectation(description: "response")

        URLProtocolMock.requestHandler = { request in
            let apiURL = URL(string: "https://localhost:8080/lastfm/dummy/path")!
            let response = HTTPURLResponse(url: apiURL, statusCode: 422, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await sut.requestData(from: endpoint)
        } catch {
            let networkError = error as! NetworkError
            XCTAssertEqual(networkError, .untrackedError(statusCode: 422))
            expectation.fulfill()
        }
    }

    func testShouldRaiseNetworkErrorWhenTheresAUnspecifiedError() async throws {

        let expectation = XCTestExpectation(description: "response")

        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        do {
            _ = try await sut.requestData(from: endpoint)
        } catch {
            let networkError = error as! NetworkError
            XCTAssertEqual(networkError, .unspecifiedError)
            expectation.fulfill()
        }
    }
}
