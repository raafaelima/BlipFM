//
//  Album.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct Album: Identifiable, Equatable {
    let id = UUID().uuidString
    let mbid: String
    let name: String
    let artist: String
    let images: [AlbumImage]

    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.mbid == rhs.mbid || lhs.name == rhs.name
    }

    func thumbnailURL() -> URL? {
        let albumImage = images.first(where: { $0.size == "small" })!
        return URL(string: albumImage.url)
    }
}
