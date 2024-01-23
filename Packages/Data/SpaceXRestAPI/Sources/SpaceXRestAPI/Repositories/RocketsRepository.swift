//
//  RocketsRepository.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Combine
import SpaceXDomain
import NetworkService

public enum RocketsRepositoryError: Error {
    case invalid
}

public final class DefaultRocketsRepository {
    private let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension DefaultRocketsRepository: RocketsRepository {
    public func fetchRockets() -> AnyPublisher<[Rocket], Error> {
        networkService.request(SpaceXRestAPIRouter.rockets)
            .map { (items: [RocketDTO]) in
                items.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchRocket(id: String) -> AnyPublisher<Rocket, Error> {
        networkService.request(SpaceXRestAPIRouter.rocket(id: id))
            .map { (rocketDTO: RocketDTO) in
                rocketDTO.toDomain()
            }
        .eraseToAnyPublisher()    }
}
