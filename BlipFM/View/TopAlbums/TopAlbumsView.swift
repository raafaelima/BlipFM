//
//  TopAlbumsView.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import SwiftUI

struct TopAlbumsView: View {
    @StateObject var viewModel = TopAlbumsViewModel()

    var body: some View {
        VStack {
            List(viewModel.albums) { album in
                albumRow(album)
                    .onAppear {
                        viewModel.requestMoreItemsIfNeeded(album)
                    }
            }
        }
        .onAppear {
            viewModel.fetchTopAlbums()
        }
        .navigationTitle("Top Hip-Hop Albuns")
    }

    private func albumRow(_ album: Album) -> some View {
        HStack(spacing: 20) {
            albumThumbnail(album.thumbnailURL())
            albumInfo(album)
        }
        .padding(.vertical, 5)
    }

    private func albumThumbnail(_ thumbnailURL: URL?) -> some View {
        AsyncImage(url: thumbnailURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image(systemName: "photo.fill")
        }.frame(width: 50, height: 50)
    }

    private func albumInfo(_ album: Album) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(album.name)
                .font(.system(size: 16, weight: .bold))
                .lineLimit(2)
            Text(album.artist)
                .font(.system(size: 14, weight: .light))
        }
    }
}

#if DEBUG
struct TopAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TopAlbumsView(viewModel: PreviewAlbumsViewModel())
        }
    }
}

class PreviewAlbumsViewModel: TopAlbumsViewModel {

    @MainActor
    override func fetchTopAlbums() {

        let images = [
            AlbumImage(url: "https://icons-for-free.com/download-icon-fm+lastfm+logo+icon-1320086786776640164_32.png", size: "small")
        ]

        self.albums = [
            Album(mbid: "", name: "Album1", artist: "Artist1", images: images),
            Album(mbid: "", name: "Album2", artist: "Artist2", images: images)
        ]
    }
}
#endif
