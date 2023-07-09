//
//  DataParser.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

protocol DataParser {
    func process<T: Decodable>(data: Data) throws -> T
}
