//
//  RocketDetailView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import SpaceXDomain
import SwiftUI

/// `RocketDetailView` presents detailed information about a specific rocket.
/// It dynamically adjusts its layout based on the device's horizontal size class.
struct RocketDetailView: View {
    @StateObject var viewModel: RocketDetailViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: LayoutConstants.standardSpacing) {
                Text(viewModel.rocket.name.uppercased())
                    .font(.spaceXLargeTitle)

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
    }
}

// MARK: - Subviews
private extension RocketDetailView {
    /// Vertical stack layout for the rocket's description and technical data.
    var descriptionAndDataVStack: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.standardSpacing) {
            Text(viewModel.rocket.description)
                .font(.spaceXBody)
                .lineSpacing(LayoutConstants.textLineSpacing)
            technicalData
        }
    }

    /// Horizontal stack layout for the rocket's description and technical data.
    var descriptionAndDataHStack: some View {
        HStack(alignment: .top, spacing: LayoutConstants.standardSpacing) {
            Text(viewModel.rocket.description)
                .font(.spaceXBody)
                .lineSpacing(LayoutConstants.textLineSpacing)
            technicalData
        }
    }

    /// View for displaying technical data of the rocket.
    var technicalData: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.sectionSpacing) {
            Text("Overview".uppercased())
                .font(.spaceXTitle2)

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

    /// Placeholder view for future launches information.
    var launchesSection: some View {
        // TODO: Launches Info
        // TODO: Launches List
        VStack(alignment: .leading, spacing: LayoutConstants.sectionSpacing) {
            Text("Launches".uppercased())
                .font(.spaceXTitle2)
            Text("Coming Soon")
        }
    }

    /// `ImageSlider` displays a horizontal scrollable view of rocket images.
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
                        .frame(
                            width: UIScreen.main.bounds.width - LayoutConstants.imageSliderPadding,
                            height: LayoutConstants.imageSliderHeight)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
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

    /// `DataRow` presents a title and value in a horizontal layout.
    struct DataRow: View {
        var title: LocalizedStringKey
        var value: String

        var body: some View {
            HStack {
                Text(title)
                    .font(.spaceXHeadline)
                Spacer()
                Text(value)
                    .font(.spaceXSubheadline)
            }
        }
    }
}

// MARK: - Layout
private extension RocketDetailView {
    enum LayoutConstants {
        // General Layout
        static let standardSpacing: CGFloat = 20
        static let sectionSpacing: CGFloat = 15
        static let cornerRadius: CGFloat = 10
        static let textLineSpacing: CGFloat = 8

        // Image Slider
        static let imageSliderPadding: CGFloat = 60
        static let imageSliderHeight: CGFloat = 300
        static let imageSliderHorizontalPadding: CGFloat = 60

        // DataRow
        static let dataRowSpacing: CGFloat = 15
    }
}

#Preview {
    RocketDetailView(viewModel: RocketDetailViewModel(rocket: Rocket.mock))
}
