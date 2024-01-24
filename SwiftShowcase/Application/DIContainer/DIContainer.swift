//
//  DIContainer.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation
import NetworkService
import SpaceXDomain
import SpaceXRestAPI

class DIContainer {
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var rocketsRepository: RocketsRepository = DefaultRocketsRepository(networkService: networkService)
    lazy var fetchRocketsUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: rocketsRepository)
}
