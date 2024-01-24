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

    var body: some View {
        content
            .padding()
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
        // TODO: Implement states
        switch viewModel.state {
        case .loading, .idle:
            ProgressView()
        case .finished(let models):
            rocketsList(models: models)
        case .empty:
            Text("No rockets 🚀 found")
        case .error(let message):
            // TODO: Implement Error view
            Text("Error: \(message)")
        }
    }

    func rocketsList(models: [Rocket]) -> some View {
        VStack(spacing: 20) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(models, id: \.id) { model in
                        Text(model.name)
                    }
                }
            }
        }
    }
}

#Preview {
    let diContainer = PreviewDIContainer()
    let viewModel = RocketsListViewModel(fetchRocketsUseCase: diContainer.fetchRocketsUseCase)
    return RocketsListView(viewModel: viewModel)
}
