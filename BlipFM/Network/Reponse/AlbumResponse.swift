//
//  AlbumResponse.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct AlbumResponse: Decodable {
    let albums: [Album]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case albums

        enum AlbumCodingKeys: String, CodingKey {
            case album
            case attr = "@attr"
        }

        enum AttrCodingKeys: String, CodingKey {
            case totalPages
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let albumContainer = try container.nestedContainer(keyedBy: CodingKeys.AlbumCodingKeys.self, forKey: .albums)
        self.albums = try albumContainer.decode([Album].self, forKey: .album)

        let attrContainer = try albumContainer.nestedContainer(keyedBy: CodingKeys.AttrCodingKeys.self, forKey: .attr)
        self.totalPages = Int(try attrContainer.decode(String.self, forKey: .totalPages)) ?? 0
    }
}
