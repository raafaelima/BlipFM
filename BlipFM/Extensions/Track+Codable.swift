//
//  Track+Codable.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

extension Track: Decodable {

    enum CodingKeys: String, CodingKey {

        case name
        case duration
        case url
        case attr = "@attr"

        enum AttrCodingKeys: String, CodingKey {
            case rank
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)

        do {
            self.duration = try container.decode(Int?.self, forKey: .duration) ?? 0
        } catch {
            self.duration = 0
        }

        let attrContainer = try container.nestedContainer(keyedBy: CodingKeys.AttrCodingKeys.self, forKey: .attr)
        self.rank = try attrContainer.decode(Int.self, forKey: .rank)
    }
}
