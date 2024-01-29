//
//  DIContainer.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation
import NetworkService
import SpaceXDomain
import SpaceXGraphQL
import SpaceXRestAPI

class DIContainer: ObservableObject {
    // MARK: NetworkService
    lazy var networkService: NetworkServiceProtocol = NetworkService()

    lazy var gqlNetworkService: GQLNetworServiceProtocol = {
        let url = "https://spacex-production.up.railway.app"
        guard let endpointURL = URL(string: url) else {
            fatalError("URL \(url) is invalid")
        }

        return ApolloClientFactory(endpoint: endpointURL)
            .networkService
    }()

    // MARK: Default Dependencies
    lazy var rocketsRepository: RocketsRepository = DefaultRocketsRepository(networkService: networkService)
    lazy var fetchRocketsUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: rocketsRepository)

    // MARK: GraphQL Dependencies
    lazy var rocketsGQLRepository: RocketsRepository = RocketsGQLRepository(networkService: gqlNetworkService)
    lazy var fetchRocketsGQLUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: rocketsGQLRepository)


    // MARK: - SceneFactories
    @MainActor
    lazy var rocketsSceneFactory = RocketsSceneFactory(dependencies: self)
}

extension DIContainer: RocketsSceneFactoryDependencies {}
