//
//  ServiceError.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

enum ServiceError: Error {
    case invalidSourceData
    case networkNotReachable
    case unspecifiedError
}
