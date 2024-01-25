//
//  ApolloClientFactory.swift
//
//
//  Created by Alex Schäfer on 25.01.24.
//

import Apollo
import Foundation

public final class ApolloClientFactory {
    private let endpoint: URL

    public lazy var networkService: GQLNetworServiceProtocol = {
        makeNetworkService()
    }()

    public init(endpoint: URL) {
        self.endpoint = endpoint
    }
}

private extension ApolloClientFactory {
    func makeNetworkService() -> GQLNetworServiceProtocol {
        // TODO: Add Caching & Store handling
        let client = ApolloClient(url: endpoint)
        return GQLNetworService(client: client)
    }
}
