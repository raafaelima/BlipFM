//
//  AppConfiguration.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct AppConfiguration {

    static let shared = AppConfiguration()

    let host: String
    let apiKey: String
    let contentType: String
    let requestType: String

    private init() {
        self.host = AppConfiguration.fromBundle(.host)
        self.apiKey = AppConfiguration.fromBundle(.apiKey)
        self.contentType = AppConfiguration.fromBundle(.contentType)
        self.requestType = AppConfiguration.fromBundle(.requestType)
    }

    private static func fromBundle(_ key: ConfigKey) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as? String ?? ""
    }
}

private enum ConfigKey: String {
    case host = "Host"
    case apiKey = "ApiKey"
    case contentType = "ContentType"
    case requestType = "RequestType"
}
