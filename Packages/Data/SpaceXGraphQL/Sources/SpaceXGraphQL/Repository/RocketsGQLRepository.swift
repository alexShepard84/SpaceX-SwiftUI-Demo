//
//  RocketsGQLRepository.swift
//
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import Foundation
import OSLog
import SpaceXDomain
import NetworkService
import OSLog

public enum RocketsGQLRepositoryError: Error {
    case invalid
}

public final class RocketsGQLRepository {
    private let networkService: GQLNetworServiceProtocol
    // TODO: Inject
    private let logger = Logger()

    public init(networkService: GQLNetworServiceProtocol) {
        self.networkService = networkService
    }
}

extension RocketsGQLRepository: RocketsRepository {
    public func fetchRockets() -> AnyPublisher<[Rocket], Error> {
        logger.info("Fetch data from GraphQL")

        return networkService
            .request(for: RocketsQuery())
            .mapToModel()
            .eraseToAnyPublisher()
    }

    public func fetchRocket(id: String) -> AnyPublisher<Rocket, Error> {
        Fail(error: RocketsGQLRepositoryError.invalid).eraseToAnyPublisher()
    }
}

// MARK: - Private helper to map GQL Model to Domain entity
private extension Publisher {
    /// Maps `RocketQuery.Data` into  `Rocket`
    func mapToModel() -> Publishers.CompactMap<Self, [SpaceXDomain.Rocket]> where Self.Output == SpaceXGraphQL.RocketsQuery.Data {
        compactMap { data in
            data.rockets?.compactMap { $0?.toDomain() }
        }
    }
}

