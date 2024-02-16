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
                Text(viewModel.output.rocket.name.uppercased())
                    .font(.spaceXTitle)

                ImageSlider(imageUrls: viewModel.output.rocket.images)

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
        .task {
            viewModel.loadLaunches()
        }
        .safeAreaPadding()
    }
}

// MARK: - Subviews
private extension RocketDetailView {
    /// Vertical stack layout for the rocket's description and technical data.
    var descriptionAndDataVStack: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.standardSpacing) {
            Text(viewModel.output.rocket.description)
                .font(.spaceXBody)
                .lineSpacing(LayoutConstants.textLineSpacing)
            technicalData
        }
    }

    /// Horizontal stack layout for the rocket's description and technical data.
    var descriptionAndDataHStack: some View {
        HStack(alignment: .top, spacing: LayoutConstants.standardSpacing) {
            Text(viewModel.output.rocket.description)
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

            DataRow(title: "Height", value: viewModel.output.formattedHeight)
            DataRow(title: "Width", value: viewModel.output.formattedDiameter)
            DataRow(title: "Mass", value: viewModel.output.formattedMass)
            ForEach(viewModel.output.formattedPayloadWeights) { weight in
                DataRow(
                    title: "Payload to \(weight.id.uppercased())",
                    value: weight.value
                )
            }
        }
    }

    /// Placeholder view for future launches information.
    @ViewBuilder
    var launchesSection: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.sectionSpacing) {
            if let totalLaunches = viewModel.output.totalLaunches {
                LaunchesCounterView(totalLaunches: totalLaunches)
            }

            Text("Latest Launch".uppercased())
                .font(.spaceXTitle2)

            Image(.launch)
                .resizable()
                .aspectRatio(16 / 9, contentMode: .fill)
                .textOverlay(text: viewModel.output.formattedLaunchDate)
                .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
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
                        CustomAsyncImageView(url: url)
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

    struct LaunchesCounterView: View {
        let totalLaunches: Int
        @State private var launchesCounter = 0

        var body: some View {
            VStack(alignment: .center) {
                Color.clear
                    .frame(maxWidth: .infinity, alignment: .center)
                    .animatingOverlay(for: launchesCounter)
                    .font(.spaceXLargeTitle)
                Text("Total Launches")
                    .font(.spaceXTitle3)
            }
            .frame(height: 80)
            .onBecomingVisible {
                withAnimation(.easeInOut(duration: 2)) {
                    launchesCounter = totalLaunches
                }
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
    let diContainer = PreviewDIContainer()
    let viewModel = RocketDetailViewModel(rocket: Rocket.mock, fetchLastLaunchUseCase: diContainer.fetchLastLaunchUseCase)

    return RocketDetailView(
        viewModel: viewModel
    )
}
