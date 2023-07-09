//
//  Endpoint.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import Foundation

protocol Endpoint {
    var path: EndpointPath { get set }
    var params: [URLQueryItem] { get set }
}
