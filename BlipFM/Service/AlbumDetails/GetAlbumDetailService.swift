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
    private let cacheManager: CacheManager<AlbumDetailResponse>

    init(networkProvider: NetworkProvider = URLSessionNetworkProvider(),
         parser: DataParser = JsonDataParser(),
         cacheManager: CacheManager<AlbumDetailResponse> = CacheManager<AlbumDetailResponse>()) {
        self.parser = parser
        self.cacheManager = cacheManager
        self.networkProvider = networkProvider
    }

    func fetchDetails(of album: Album) async throws -> AlbumDetailResponse {
        let endpoint = GetAlbumDetailsEndpoint(album: album)

        do {
            let data = try await networkProvider.requestData(from: endpoint)
            let parsedData: AlbumDetailResponse = try parser.process(data: data)
            cacheManager.setObject(parsedData, forKey: .albumDetailResponse)
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

    private func retrieveDataFromCache() throws -> AlbumDetailResponse {
        guard let response = cacheManager.getObject(forKey: .albumDetailResponse) else {
            throw ServiceError.invalidSourceData
        }
        return response
    }
}
