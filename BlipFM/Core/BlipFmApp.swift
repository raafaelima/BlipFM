//
//  BlipFmApp.swift
//  BlipFM
//
//  Created by Lima, Rafael on 07/07/2023.
//

import SwiftUI
import StoreKit

@main
struct BlipFmApp: App {

    private let timesOpenBeforeRequestForReview = 9
    @AppStorage("review.counter") private var reviewCounter = 1

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TopAlbumsView()
                    .onAppear(perform: requestReview)
            }
        }
    }

    private func requestReview() {
        reviewCounter += 1

        if reviewCounter > timesOpenBeforeRequestForReview {
            reviewCounter = 0
            DispatchQueue.main.async {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
    }
}
