//
//  JsonDataParserMock.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation
@testable import BlipFM

class JsonDataParserMock: DataParser {

    var forceError: Bool = false
    private var jsonSource = ""

    convenience init(jsonSource: String) {
        self.init()
        self.jsonSource = jsonSource
    }

    func process<T: Decodable>(data: Data) throws -> T {
        if forceError {
            throw ParserError.invalidData
        } else {
            return JSONHelper.getObjectFrom(json: jsonSource, type: T.self)!
        }
    }
}
