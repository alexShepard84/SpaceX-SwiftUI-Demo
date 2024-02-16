//
//  MockLaunchesRepository.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 13.02.24.
//

import Combine
import Foundation
import SpaceXDomain

// swiftlint:disable all
class MockLaunchesRepository: LaunchesRepository {
    func fetchLaunches(with request: SpaceXDomain.QueryRequest?) async throws -> SpaceXDomain.Paginated<SpaceXDomain.Launch> {
        return Paginated(
            items: [
                Launch(
                    id: "Launch1",
                    details: "Lorem Ipsum",
                    rocketId: "Rocket1",
                    date: Date()
                )
            ],
            totalDocs: 10,
            totalPages: 2,
            page: 1,
            hasNextPage: true,
            hasPrevPage: false
        )
    }
}
