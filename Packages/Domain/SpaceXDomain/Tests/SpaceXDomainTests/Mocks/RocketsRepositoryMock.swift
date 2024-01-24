//
//  RocketsRepositoryMock.swift
//
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import Foundation
import SpaceXDomain

final class RocketsRepositoryMock: RocketsRepository {
    private(set) var fetchRocketsCalled = false
    var fetchRocketsReturn = Just<[Rocket]>([]).setFailureType(to: Error.self).eraseToAnyPublisher()

    func fetchRockets() -> AnyPublisher<[Rocket], Error> {
        fetchRocketsCalled = true
        return fetchRocketsReturn
    }
    
    private(set) var fetchRocketCalledWithId: String?
    var fetchRocketReturn = Empty<Rocket, Error>().eraseToAnyPublisher()

    func fetchRocket(id: String) -> AnyPublisher<Rocket, Error> {
        fetchRocketCalledWithId = id
        return fetchRocketReturn
    }
}

