//
//  AlbumDetailsView.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import SwiftUI

struct AlbumDetailsView: View {

    @StateObject var viewModel: AlbumDetailsViewModel

    init(album: Album) {
        let albumDetailsVM = AlbumDetailsViewModel(album: album)
        self._viewModel = StateObject(wrappedValue: albumDetailsVM)
    }

    var body: some View {

        VStack(spacing: 5) {
            HStack {
                albumInfo()
                Spacer()
                albumImage(viewModel.albumDetail.albumCoverURL())
            }
            .padding(.horizontal)

            listenersAndScrobles()

            if !viewModel.albumDetail.summary.isEmpty {
                Text(viewModel.albumDetail.summary)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            }

            topTracks()
        }
        .onAppear {
            viewModel.fetchAlbumDetails()
        }
        .redacted(reason: viewModel.state == .loading ? .placeholder : [])
        .preferredColorScheme(.dark)
    }

    private func albumImage(_ thumbnailURL: URL?) -> some View {
        AsyncImage(url: thumbnailURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image(systemName: "photo.fill")
        }.frame(width: 100, height: 100)
    }

    private func albumInfo() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.albumDetail.name)
                .font(.title)
                .lineLimit(1)

            Text(viewModel.albumDetail.artist)
                .font(.title3)
                .lineLimit(1)
        }
    }

    private func listenersAndScrobles() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(viewModel.albumDetail.playcount.formatted()) scrobbles")
                .font(.headline)
                .foregroundColor(.gray)

            Text("\(viewModel.albumDetail.listeners.formatted()) listeners")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func topTracks() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Top Tracks")
                .font(.title)
                .padding(.horizontal)
                .padding(.top, 30)

            List(viewModel.albumDetail.tracks) { track in
               trackRow(track)
            }
        }
    }

    private func trackRow(_ track: Track) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(track.name)
                .font(.system(size: 16, weight: .bold))

            let trackDuration: Duration = .seconds(track.duration)
            Text("\(trackDuration, format: .time(pattern: .minuteSecond)) min")
                .font(.system(size: 14, weight: .light))
        }
    }
}

struct AlbumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumDetailsView(album: Album(mbid: "id", name: "Album", artist: "Artist", images: []))
        }
    }
}
