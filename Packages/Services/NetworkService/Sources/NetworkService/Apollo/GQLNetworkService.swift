//
//  GQLNetworService.swift
//
//
//  Created by Alex Schäfer on 24.01.24.
//

import Apollo
import ApolloAPI
import ApolloCombine
import Combine
import Foundation


enum GQLNetworServiceError: Error {
    case gqlErrors([Error]?)
}

public protocol GQLNetworServiceProtocol {
   func request<Query: GraphQLQuery>(for query: Query) -> AnyPublisher<Query.Data, Error>
}

public class GQLNetworService: GQLNetworServiceProtocol {
    private let client: ApolloClientProtocol
    
    public init(client: ApolloClientProtocol) {
        self.client = client
    }

    public func request<Query: GraphQLQuery>(for query: Query) -> AnyPublisher<Query.Data, Error> {
        // TODO: Error Handling
        client.fetchPublisher(query: query)
            .tryMap { gqlResult in
                guard let data = gqlResult.data else {
                    throw GQLNetworServiceError.gqlErrors(gqlResult.errors)
                }

                return data
            }
            .eraseToAnyPublisher()
    }
}
