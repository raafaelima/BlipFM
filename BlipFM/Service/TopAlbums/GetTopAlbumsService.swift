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
    private let cacheManager: CacheManager<AlbumResponse>

    init(networkProvider: NetworkProvider = URLSessionNetworkProvider(),
         parser: DataParser = JsonDataParser(),
         cacheManager: CacheManager<AlbumResponse> = CacheManager<AlbumResponse>()) {
        self.parser = parser
        self.cacheManager = cacheManager
        self.networkProvider = networkProvider
    }

    func fetchTopAlbuns(ofGenre genre: String, page: Int = 1) async throws -> AlbumResponse {
        let endpoint = GetTopAlbunsEndpoint(genre: genre, page: page)

        do {
            let data = try await networkProvider.requestData(from: endpoint)
            let parsedData: AlbumResponse = try parser.process(data: data)
            cacheManager.setObject(parsedData, forKey: .topAlbunsResponse)
            return parsedData
        } catch {
            if let networkError = error as? NetworkError, networkError == .notReachable {
                return try retrieveDataFromCache()
            } else {
                throw handleError(error)
            }
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

    private func retrieveDataFromCache() throws -> AlbumResponse {
        guard let response = cacheManager.getObject(forKey: .topAlbunsResponse) else {
            throw ServiceError.invalidSourceData
        }

        return response
    }
}
