//
//  PreviewDIContainer.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 24.01.24.
//

import SpaceXDomain

class PreviewDIContainer {
    lazy var mockRocketsRepository: RocketsRepository = MockRocketsRepository()
    lazy var fetchRocketsUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: mockRocketsRepository)
}
