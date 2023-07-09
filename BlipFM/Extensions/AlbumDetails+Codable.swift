//
//  AlbumDetails+Codable.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

extension AlbumDetails: Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case image
        case tracks
        case listeners
        case playcount
        case wiki

        enum TrackCodingKeys: String, CodingKey {
            case track
        }

        enum SummaryCodingKeys: String, CodingKey {
            case summary
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.images = try container.decode([AlbumImage].self, forKey: .image)
        self.listeners = Int(try container.decode(String.self, forKey: .listeners)) ?? 0
        self.playcount = Int(try container.decode(String.self, forKey: .playcount)) ?? 0

        let trackContainer = try container.nestedContainer(keyedBy: CodingKeys.TrackCodingKeys.self, forKey: .tracks)
        self.tracks = try trackContainer.decode([Track].self, forKey: .track)

        do {
            let wikiContainer = try container.nestedContainer(keyedBy: CodingKeys.SummaryCodingKeys.self, forKey: .wiki)
            self.summary = try wikiContainer.decode(String.self, forKey: .summary)
        } catch {
            self.summary = ""
        }
    }
}
