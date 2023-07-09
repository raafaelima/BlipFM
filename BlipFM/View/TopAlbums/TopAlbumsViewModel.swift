//
//  TopAlbumsViewModel.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

enum TopAlbunsUIState {
    case idle
    case loadingFirstPage
    case loadingNextPage
    case loaded
}

class TopAlbumsViewModel: ObservableObject {

    @Published var albums: [Album] = []

    private var threshold: Int = -5
    private var totalPages: Int = 2
    private var currentPage: Int = 1
    private var state: TopAlbunsUIState = .idle
    private let getTopAlbumsService: GetTopAlbumsService = GetTopAlbumsService()

    private var currentTask: Task<Void, Never>? {
        willSet {
            if let task = currentTask {
                if task.isCancelled { return }
                task.cancel()
            }
        }
    }

    func fetchTopAlbums() {
        currentPage = 1
        state = .loadingFirstPage
        fetchAlbums(page: currentPage)
    }

    func fetchNextPage() {
        currentPage += 1
        state = .loadingNextPage
        fetchAlbums(page: currentPage)
    }

    private func fetchAlbums(page: Int) {
        currentTask = Task {
            do {
                let albumResponse = try await getTopAlbumsService.fetchTopAlbuns(ofGenre: "hip-hop", page: currentPage)

                DispatchQueue.main.async { [weak self] in
                    self?.albums.append(contentsOf: albumResponse.albums)
                    self?.totalPages = albumResponse.totalPages
                    self?.state = .loaded
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func cantLoadMorePages() -> Bool {
        currentPage >= totalPages
    }

    @MainActor
    public func requestMoreItemsIfNeeded(_ model: Album) {

        if cantLoadMorePages() {
            return
        }

        if state == .loadingNextPage || state == .loadingFirstPage {
            return
        }

        guard let index = albums.firstIndex(where: { $0.id == model.id }) else {
            return
        }

        let thresholdIndex = albums.index(albums.endIndex, offsetBy: threshold)
        if index != thresholdIndex {
            return
        }

        fetchNextPage()
    }
}
