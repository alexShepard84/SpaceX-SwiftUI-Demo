//
//  FetchRocketLaunchesUseCase.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

// MARK: - FetchRocketsUseCaseError
public enum FetchRocketLaunchesUseCaseError: Error {
    case invalid
    case forward(Error)
}

// MARK: - FetchRocketLaunchesUseCase Protocol
public protocol FetchRocketLaunchesUseCase {
    /// Fetches an array of `Launch` for a specific rocket asynchronously.
    /// - Parameter rocketId: The unique identifier of the rocket.
    func execute(rocketId: String) async throws -> Paginated<Launch>
}

// MARK: - FetchRocketLaunchesUseCase Default Implementation
public final class DefaultFetchRocketLaunchesUseCase: FetchRocketLaunchesUseCase {
    private let repository: LaunchesRepository

    public init(repository: LaunchesRepository) {
        self.repository = repository
    }

    // TODO: Add page and limit
    public func execute(rocketId: String) async throws -> Paginated<Launch> {
        do {
            let request = QueryRequest(filter: ["rocketId": rocketId])
            let launches = try await repository.fetchLaunches(with: request)

            return launches
        } catch {
            throw FetchRocketLaunchesUseCaseError.forward(error)
        }
    }
}
