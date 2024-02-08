//
//  RocketDetailView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import SpaceXDomain
import SwiftUI

struct RocketDetailView: View {
    @StateObject var viewModel: RocketDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageSlider(imageUrls: viewModel.rocket.images)

                Text(viewModel.rocket.description)
                // Technical Data Overview

                Text("Overview")
                    .font(.title)

                VStack {
                    DataRow(title: "Height", value: viewModel.formattedHeight)
                    DataRow(title: "Width", value: viewModel.formattedDiameter)
                    DataRow(title: "Mass", value: viewModel.formattedMass)
                    ForEach(viewModel.formattedPayloadWeights) { weight in
                        DataRow(
                            title: "Payload to \(weight.id.uppercased())",
                            value: weight.value
                        )
                    }
                }

                Text("Launches")
                    .font(.title)
                Text("Coming Soon")
            }
        }
        .safeAreaPadding()
        .navigationTitle(viewModel.rocket.name)

        // TODO: Launches Info
        // TODO: Launches List
        //        Text(viewModel.rocket.name)
    }
}

// Views
private extension RocketDetailView {
    struct ImageSlider: View {
        var imageUrls: [URL]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(imageUrls, id: \.self) { url in
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Color.gray
                            case .success(let image):
                                image
                                    .resizable()
                            case .failure:
                                Color.gray
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .aspectRatio(16 / 9, contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    struct DataRow: View {
        var title: LocalizedStringKey
        var value: String

        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(value)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    RocketDetailView(viewModel: RocketDetailViewModel(rocket: Rocket.mock))
}
