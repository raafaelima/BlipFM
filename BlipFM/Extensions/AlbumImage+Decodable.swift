//
//  AlbumImage+Decodable.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

extension AlbumImage: Decodable {

    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.size = try container.decode(String.self, forKey: .size)
    }
}
