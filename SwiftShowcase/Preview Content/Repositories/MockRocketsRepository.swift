//
//  MockRocketsRepository.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import Foundation
import SpaceXDomain

// swiftlint:disable force_unwrapping
class MockRocketsRepository: RocketsRepository {
    func fetchRockets() -> AnyPublisher<[SpaceXDomain.Rocket], Error> {
        let mockRockets = [
            Rocket(
                id: "1",
                name: "Mock Rocket 1",
                country: "USA",
                description: "This is a mock rocket.",
                images: [
                    URL(string: "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg")!
                ],
                firstFlight: nil,
                active: true,
                technicalData: RocketTechnicalData.mock
            ),
            Rocket(
                id: "2",
                name: "Mock Rocket 2",
                country: "USA",
                description: "This is a another mock rocket.",
                images: [
                    URL(string: "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg")!
                ],
                firstFlight: nil,
                active: true,
                technicalData: RocketTechnicalData.mock
            ),
            Rocket(
                id: "3",
                name: "Mock Rocket 3",
                country: "USA",
                description: "This is a another mock rocket.",
                images: [
                    URL(string: "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg")!
                ],
                firstFlight: nil,
                active: true,
                technicalData: RocketTechnicalData.mock
            ),
            Rocket(
                id: "4",
                name: "Mock Rocket 4",
                country: "USA",
                description: "This is a another mock rocket.",
                images: [
                    URL(string: "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg")!
                ],
                firstFlight: nil,
                active: true,
                technicalData: RocketTechnicalData.mock
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
            active: true,
            technicalData: RocketTechnicalData.mock
        )

        return Just(mockRocket)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
