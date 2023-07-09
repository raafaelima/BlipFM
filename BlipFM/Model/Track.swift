//
//  Track.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct Track: Identifiable {
    let id = UUID().uuidString
    let name: String
    let duration: Int
    let url: String
    let rank: Int
}
