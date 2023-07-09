//
//  JsonDataParser.swift
//  BlipFM
//
//  Created by Lima, Rafael on 08/06/2023.
//

import Foundation

struct JsonDataParser: DataParser {

    func process<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error on parsing data: \(error.localizedDescription)")
            throw ParserError.invalidData
        }
    }
}
