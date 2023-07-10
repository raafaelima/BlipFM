//
//  GetAlbumDetailsEndpoint.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct GetAlbumDetailsEndpoint: Endpoint {
    var path: EndpointPath = .getAlbumInfo
    var params: [URLQueryItem] = []

    init(album: Album) {
        if album.mbid.isEmpty {
            let artistParam = URLQueryItem(name: EnpointQueryItemKey.artist.rawValue, value: album.artist)
            let albumParam = URLQueryItem(name: EnpointQueryItemKey.album.rawValue, value: album.name)
            self.params.append(contentsOf: [artistParam, albumParam])
        } else {
            let mbIdParam = URLQueryItem(name: EnpointQueryItemKey.mbid.rawValue, value: album.mbid)
            self.params.append(mbIdParam)
        }
    }
}
