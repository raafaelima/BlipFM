//
//  URLSessionNetworkProviderMock.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation
@testable import BlipFM

class URLSessionNetworkProviderMock: NetworkProvider {

    var forceError = false
    var didCallRequestData = false
    var endpointRequestURL = ""
    var jsonSource = ""

    convenience init(jsonSource: String) {
        self.init()
        self.jsonSource = jsonSource
    }

    func requestData(from endpoint: Endpoint) async throws -> Data {
        self.didCallRequestData = true
        self.endpointRequestURL = try endpoint.urlRequest().url!.absoluteString

        if forceError {
            throw NetworkError.unspecifiedError
        } else {
            return JSONHelper.getDataFrom(json: jsonSource)!
        }
    }
}
