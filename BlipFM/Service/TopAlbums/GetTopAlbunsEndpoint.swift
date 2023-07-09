//
//  GetTopAlbunsEndpoint.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct GetTopAlbunsEndpoint: Endpoint {
    var path: EndpointPath = .getTopAlbums
    var params: [URLQueryItem]

    init(genre: String, page: Int, limit: Int = 50) {
        self.params = [
            URLQueryItem(name: EnpointQueryItemKey.tag.rawValue, value: genre),
            URLQueryItem(name: EnpointQueryItemKey.page.rawValue, value: String(page)),
            URLQueryItem(name: EnpointQueryItemKey.limit.rawValue, value: String(limit))
        ]
    }
}
