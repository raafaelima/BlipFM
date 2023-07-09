//
//  AlbumDetailsViewModel.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

enum AlbumDetailsUIState {
    case idle
    case loading
    case loaded
}

class AlbumDetailsViewModel: ObservableObject {

    @Published var albumDetail: AlbumDetails
    @Published var state: AlbumDetailsUIState

    private let album: Album
    private let getAlbumDetailService: GetAlbumDetailService

    init(album: Album) {
        self.album = album
        self.state = .idle
        self.getAlbumDetailService = GetAlbumDetailService()
        self.albumDetail = AlbumDetailsViewModel.redactedDetails()
    }

    @MainActor
    func fetchAlbumDetails() {
        state = .loading

        Task {
            do {
                let details = try await getAlbumDetailService.fetchDetails(of: album)
                self.albumDetail = details.album
                self.state = .loaded
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private static func redactedDetails() -> AlbumDetails {
        let images = [AlbumImage(url: "", size: "large")]
        let dummyTrack = Track(name: "Track1", duration: 123, url: "Track1", rank: 1)
        let tracks = [dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack, dummyTrack]
        return AlbumDetails(artist: "Artist", name: "AlbumName", tracks: tracks, listeners: 12345, playcount: 123456, summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", images: images)
    }
}
