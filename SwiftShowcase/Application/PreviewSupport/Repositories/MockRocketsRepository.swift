//
//  MockRocketsRepository.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import Foundation
import SpaceXDomain

class MockRocketsRepository: RocketsRepository {
    func fetchRockets() -> AnyPublisher<[SpaceXDomain.Rocket], Error> {
        let mockRockets = [
            Rocket(
                id: "1",
                name: "Mock Rocket 1",
                country: "USA",
                description: "This is a mock rocket.",
                images: [],
                firstFlight: nil,
                active: true
            ),
            Rocket(
                id: "2",
                name: "Mock Rocket 2",
                country: "USA",
                description: "This is a another mock rocket.",
                images: [],
                firstFlight: nil,
                active: true
            )
        ]

        return Just(mockRockets)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchRocket(id: String) -> AnyPublisher<SpaceXDomain.Rocket, Error> {
        let mockRocket = Rocket(
            id: "1",
            name: "Mock Rocket 1",
            country: "USA",
            description: "This is a mock rocket.",
            images: [],
            firstFlight: nil,
            active: true
        )

        return Just(mockRocket)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
