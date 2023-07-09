//
//  URLBuilder.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

protocol URLBuilding {
    func build(to path: String, with params: [URLQueryItem]) throws -> URL
}

enum URLBuilderError: Error {
    case malformedURL
}

struct URLBuilder: URLBuilding {
    
    func build(to path: String = "", with params: [URLQueryItem] = []) throws -> URL {
        var components = URLComponents(string: host())
        components?.queryItems = baseRequestQueryItens(to: path)
        components?.queryItems?.append(contentsOf: params)

        guard let url = components?.url else {
            throw URLBuilderError.malformedURL
        }
        
        return url
    }
    
    private func baseRequestQueryItens(to path: String) -> [URLQueryItem] {
        return [
            URLQueryItem(name: QueryItemKey.method.rawValue, value: path),
            URLQueryItem(name: QueryItemKey.apiKey.rawValue, value: apiKey()),
            URLQueryItem(name: QueryItemKey.format.rawValue, value: requestFormat())
        ]
    }
    
    private func host() -> String {
        return "https://ws.audioscrobbler.com/2.0/"
    }
    
    private func apiKey() -> String {
        return "f1c1d688022281d094891a2739284db1"
    }
    
    private func requestFormat() -> String {
        return "json"
    }
}
