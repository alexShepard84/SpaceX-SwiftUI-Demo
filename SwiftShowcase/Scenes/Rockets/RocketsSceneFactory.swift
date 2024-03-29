//
//  RocketsSceneFactory.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import SpaceXDomain
import SwiftUI

protocol RocketsSceneFactoryDependencies {
    var fetchRocketsUseCase: FetchRocketsUseCase { get }
    var fetchRocketsGQLUseCase: FetchRocketsUseCase { get }
    var fetchLastLaunchUseCase: FetchLastLaunchUseCase { get }
}

protocol RocketsSceneFactoryProtocol {
    func makeRocketsListView() -> RocketsContainerView
    func makeRocketDetailView(with rocket: Rocket) -> RocketDetailView
}

@MainActor
final class RocketsSceneFactory: ObservableObject {
    private let dependencies: RocketsSceneFactoryDependencies

    init(dependencies: RocketsSceneFactoryDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - Factory
extension RocketsSceneFactory: RocketsSceneFactoryProtocol {
    func makeRocketsListView() -> RocketsContainerView {
        let restViewModel = RocketsListViewModel(fetchRocketsUseCase: dependencies.fetchRocketsUseCase)
        let gqlViewModel = RocketsListViewModel(fetchRocketsUseCase: dependencies.fetchRocketsGQLUseCase)

        return RocketsContainerView(
            restViewModel: restViewModel,
            gqlViewModel: gqlViewModel
        )
    }

    func makeRocketDetailView(with rocket: Rocket) -> RocketDetailView {
        let viewModel = RocketDetailViewModel(
            rocket: rocket,
            fetchLastLaunchUseCase: dependencies.fetchLastLaunchUseCase
        )

        return RocketDetailView(viewModel: viewModel)
    }
}
