//
//  CustomAsyncImageView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 16.02.24.
//

import SwiftUI

/// A view component that loads and displays an image from a URL asynchronously.
///
/// This component uses `AsyncImage` to load an image from the provided URL.
/// It shows a placeholder color while the image is loading or if the loading fails.
///
/// - Parameters:
///   - url: The URL of the image to be loaded.
///   - placeholderColor: The color to display while the image is loading or if loading fails.
struct CustomAsyncImageView: View {
    let url: URL?
    var placeholderColor: Color = .gray
    // TODO: Add PlaceholderImage

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            case .empty, .failure:
                placeholderColor
            @unknown default:
                EmptyView()
            }
        }
    }
}

