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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageSlider(imageUrls: viewModel.rocket.images)

                Group {
                    if horizontalSizeClass == .compact {
                        descriptionAndDataVStack
                    } else {
                        descriptionAndDataHStack
                    }
                }

                launchesSection
            }
        }
        .safeAreaPadding()
        .navigationTitle(viewModel.rocket.name)
    }
}

// MARK: - Views
private extension RocketDetailView {
    var descriptionAndDataVStack: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.rocket.description)
            technicalData
        }
    }

    var descriptionAndDataHStack: some View {
        HStack(alignment: .top, spacing: 20) {
            Text(viewModel.rocket.description)
            technicalData
        }
    }

    var technicalData: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Overview")
                .font(.title)

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
    }

    var launchesSection: some View {
        // TODO: Launches Info
        // TODO: Launches List
        Group {
            Text("Launches")
                .font(.title)
            Text("Coming Soon")
        }
    }

    struct ImageSlider: View {
        @Environment(\.horizontalSizeClass) var horizontalSizeClass

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
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 60, height: 300)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.95)
                        }
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
