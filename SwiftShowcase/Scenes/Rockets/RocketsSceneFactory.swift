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
        let restViewModel = RocketsListViewModel(
            fetchRocketsUseCase: dependencies.fetchRocketsUseCase,
            sceneFactory: self
        )

        let gqlViewModel = RocketsListViewModel(
            fetchRocketsUseCase: dependencies.fetchRocketsGQLUseCase,
            sceneFactory: self
        )

        return RocketsContainerView(
            restViewModel: restViewModel,
            gqlViewModel: gqlViewModel
        )
    }

    func makeRocketDetailView(with rocket: Rocket) -> RocketDetailView {
        let viewModel = RocketDetailViewModel(rocket: rocket)

        return RocketDetailView(viewModel: viewModel)
    }
}
