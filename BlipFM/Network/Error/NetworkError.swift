//
//  NetworkError.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

enum NetworkError: Error, Equatable {
    case badRequest
    case unauthorized
    case internalServerError
    case unspecifiedError
    case untrackedError(statusCode: Int)
}
