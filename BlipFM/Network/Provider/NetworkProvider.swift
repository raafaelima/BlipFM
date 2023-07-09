//
//  NetworkProvider.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

protocol NetworkProvider {
    func requestData(from endpoint: Endpoint) async throws -> Data
}
