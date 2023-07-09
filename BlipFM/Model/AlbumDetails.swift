//
//  AlbumDetails.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct AlbumDetails {
    let artist: String
    let name: String
    let tracks: [Track]
    let listeners: Int
    let playcount: Int
    let summary: String
    let images: [AlbumImage]

    func albumCoverURL() -> URL? {
        let albumImage = images.first(where: { $0.size == "large" })!
        return URL(string: albumImage.url)
    }
}
