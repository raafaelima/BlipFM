//
//  Album+Codable.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

extension Album: Decodable {

    enum CodingKeys: String, CodingKey {
        case mbid
        case name
        case image
        case artist

        enum ArtistCodingKeys: String, CodingKey {
            case name
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mbid = try container.decode(String.self, forKey: .mbid)
        self.name = try container.decode(String.self, forKey: .name)
        self.images = try container.decode([AlbumImage].self, forKey: .image)

        let artistContainer = try container.nestedContainer(keyedBy: CodingKeys.ArtistCodingKeys.self, forKey: .artist)
        self.artist = try artistContainer.decode(String.self, forKey: .name)

    }
}
