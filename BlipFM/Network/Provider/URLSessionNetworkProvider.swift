//
//  URLSessionNetworkProvider.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

struct URLSessionNetworkProvider: NetworkProvider {

    var session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func requestData(from endpoint: Endpoint) async throws -> Data {
        let (data, response) = try await session.data(for: endpoint.urlRequest())

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unspecifiedError
        }

        if response.statusCode != 200 {
            throw errorFor(response)
        }

        return data
    }

    private func errorFor(_ response: HTTPURLResponse) -> NetworkError {
        switch response.statusCode {
        case 400:
            return NetworkError.badRequest
        case 401:
            return NetworkError.unauthorized
        case 500:
            return NetworkError.internalServerError
        default:
            return NetworkError.untrackedError(statusCode: response.statusCode)
        }
    }
}
