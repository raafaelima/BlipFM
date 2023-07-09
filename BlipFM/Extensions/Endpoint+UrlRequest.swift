//
//  Endpoint+UrlRequest.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        let builder: URLBuilding = URLBuilder()
        let endpointURL = try builder.build(to: path.rawValue, with: params)

        var request = URLRequest(url: endpointURL)

        print("\(endpointURL)")

        request.addValue(contentType(), forHTTPHeaderField: HeaderKey.accept.rawValue)
        request.addValue(contentType(), forHTTPHeaderField: HeaderKey.contentType.rawValue)
        return request
    }

    private func contentType() -> String {
        return AppConfiguration.shared.contentType
    }
}
