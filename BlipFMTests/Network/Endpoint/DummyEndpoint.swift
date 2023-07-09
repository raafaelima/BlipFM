//
//  DummyEndpoint.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 07/07/2023.

//

import Foundation
@testable import BlipFM

struct DummyEndpoint: Endpoint {
    var path: EndpointPath = .getAlbumInfo
    var params: [URLQueryItem] = []
}
