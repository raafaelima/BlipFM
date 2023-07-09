//
//  GetAlbumDetailService.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

struct GetAlbumDetailService {

    private let parser: DataParser
    private let networkProvider: NetworkProvider

    init( networkProvider: NetworkProvider = URLSessionNetworkProvider(), parser: DataParser = JsonDataParser()) {
        self.parser = parser
        self.networkProvider = networkProvider
    }

    func fetchDetails(of album: Album) async throws -> AlbumDetailResponse {
        let endpoint = GetAlbumDetailsEndpoint(album: album)

        do {
            let data = try await networkProvider.requestData(from: endpoint)
            return try parser.process(data: data)
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
