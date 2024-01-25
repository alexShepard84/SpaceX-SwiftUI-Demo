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
    
    lazy var apolloNetworkService: GQLNetworServiceProtocol = {
        // TODO: Read URL from environment config
        let url = "https://spacex-production.up.railway.app"
        guard let endpointURL = URL(string: url) else {
            fatalError("URL \(url) is invalid")
        }

        return ApolloClientFactory(endpoint: endpointURL)
            .networkService
    }()

    lazy var rocketsRepository: RocketsRepository = DefaultRocketsRepository(networkService: networkService)
    lazy var fetchRocketsUseCase: FetchRocketsUseCase = DefaultFetchRocketsUseCase(repository: rocketsRepository)
}
