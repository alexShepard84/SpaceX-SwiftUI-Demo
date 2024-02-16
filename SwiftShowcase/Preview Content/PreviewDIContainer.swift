//
//  PreviewDIContainer.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 24.01.24.
//

import SpaceXDomain

class PreviewDIContainer {
    lazy var mockRocketsRepository: RocketsRepository = MockRocketsRepository()
    lazy var mockLaunchesRepository: LaunchesRepository = MockLaunchesRepository()

    lazy var fetchRocketsUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: mockRocketsRepository)
    lazy var fetchRocketsGQLUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: mockRocketsRepository)
    lazy var fetchRocketLaunchesUseCase: FetchRocketLaunchesUseCase = DefaultFetchRocketLaunchesUseCase(repository: mockLaunchesRepository)
    lazy var fetchLastLaunchUseCase: FetchLastLaunchUseCase = DefaultFetchLastLaunchUseCase(repository: mockLaunchesRepository)
}

extension PreviewDIContainer: RocketsSceneFactoryDependencies {
}
