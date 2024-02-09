//
//  RocketsListView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 23.01.24.
//

import SpaceXDomain
import SwiftUI

struct RocketsListView: View {
    @StateObject var viewModel: RocketsListViewModel
    @State private var navPath = NavigationPath()
    @State private var selectedRocket: Rocket?

    var body: some View {
        content
            .navigationTitle("Rockets")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedRocket) { rocket in
                viewModel.makeRocketDetailView(rocket)
                    .toolbarRole(.editor)
            }
        .task {
            viewModel.loadSubject.send(())
        }
        .refreshable {
            viewModel.loadSubject.send(())
        }
    }
}

// MARK: - Content
private extension RocketsListView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .loading, .idle:
            ProgressView()
        case .finished(let models):
            GridView(models: models, selectedModel: $selectedRocket)
        case .empty:
            ContentUnavailableView(
                "All rockets are on a mission in outer space 🚀",
                systemImage: "sparkles",
                description: Text("Please try it later")
            )
        case .error(let message):
            ContentUnavailableView(
                "An Error Occured",
                systemImage: "exclamationmark.triangle",
                description: Text("Error: \(message)")
            )
        }
    }
}

// MARK: - Views
private extension RocketsListView {
    /// `GridView` displays a grid of rocket items.
    /// It adapts its layout based on the current horizontal and vertical size classes.
    struct GridView: View {
        // Environment properties to detect the current size class of the device.
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.verticalSizeClass) var verticalSizeClass

        var models: [Rocket]
        @Binding var selectedModel: Rocket?

        @State private var gridLayout = [GridItem()]

        var body: some View {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 15) {
                    ForEach(models) { model in
                        RocketListItemView(model: model)
                            .onTapGesture {
                                selectedModel = model
                            }
                    }
                }
                .padding()
            }
            .onAppear(perform: updateGridLayout)
            .onChange(of: horizontalSizeClass) { updateGridLayout() }
            .onChange(of: verticalSizeClass) { updateGridLayout() }
        }

        /// Updates the grid layout based on the current size class.
        private func updateGridLayout() {
            let columns: Int
            // Determine the number of columns based on size class.
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .compact), (.regular, _): // iPhone Landscape und iPad
                columns = 2
            default:
                columns = 1
            }
            gridLayout = Array(repeating: GridItem(.flexible()), count: columns)
        }
    }

    /// `RocketListItemView` represents a single rocket item
    struct RocketListItemView: View {
        var model: Rocket

        var body: some View {
            AsyncImage(url: model.images.first) { phase in
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
            .aspectRatio(16 / 9, contentMode: .fit)
            .scaledToFill()
            .clipped()
            .overlay {
                // Gradient overlay for whole image looks much better than a text background gradient
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.3), .black.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .overlay(alignment: .bottomLeading) {
                Text(model.name)
                    .font(.spaceXLargeTitle)
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// MARK: - Preview
#Preview {
    let diContainer = PreviewDIContainer()
    let sceneFactory = RocketsSceneFactory(dependencies: diContainer)
    let viewModel = RocketsListViewModel(
        fetchRocketsUseCase: diContainer.fetchRocketsUseCase,
        sceneFactory: sceneFactory
    )

    return RocketsListView(viewModel: viewModel)
}

extension Rocket: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
