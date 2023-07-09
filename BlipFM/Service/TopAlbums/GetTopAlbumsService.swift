//
//  GetTopAlbumsService.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct GetTopAlbumsService {

    private let parser: DataParser
    private let networkProvider: NetworkProvider

    init( networkProvider: NetworkProvider = URLSessionNetworkProvider(), parser: DataParser = JsonDataParser()) {
        self.parser = parser
        self.networkProvider = networkProvider
    }

    func fetchTopAlbuns(ofGenre genre: String, page: Int = 1) async throws -> [Album] {
        let endpoint = GetTopAlbunsEndpoint(genre: genre, page: page)

        do {
            let data = try await networkProvider.requestData(from: endpoint)
            let parsedResponse: AlbumResponse = try parser.process(data: data)
            return parsedResponse.albums
        } catch {
            throw handleError(error)
        }
    }

    private func handleError(_ error: Error) -> ServiceError {
        if error is NetworkError {
            return ServiceError.networkNotReachable
        } else if error is ParserError {
            return ServiceError.invalidSourceData
        } else {
            return ServiceError.unspecifiedError
        }
    }
}
