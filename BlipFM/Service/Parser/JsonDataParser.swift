//
//  JsonDataParser.swift
//  BlipFM
//
//  Created by Lima, Rafael on 08/06/2023.
//

import Foundation

struct JsonDataParser {

    func process<T: Codable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error on parsing data: \(error.localizedDescription)")
            throw error
        }
    }
}
