//
//  FetchLastLaunchUseCase.swift
//
//
//  Created by Alex Schäfer on 14.02.24.
//

import Foundation

// MARK: - FetchLastLaunchUseCaseError
public enum FetchLastLaunchUseCaseError: Error {
    case invalid
    case forward(Error)
}

// MARK: - FetchLastLaunchUseCase Protocol
public protocol FetchLastLaunchUseCase {
    /// Fetches last successful`Launch` for a specific rocket .
    /// - Parameter rocketId: The unique identifier of the rocket.
    func execute(rocketId: String) async throws -> Paginated<Launch>
}

// MARK: - FetchLastLaunchUseCase Default Implementation
public final class DefaultFetchLastLaunchUseCase: FetchLastLaunchUseCase {
    private let repository: LaunchesRepository

    public init(repository: LaunchesRepository) {
        self.repository = repository
    }

    public func execute(rocketId: String) async throws -> Paginated<Launch> {
        do {
            let request = makeQueryRequest(rocketId: rocketId)
            let launches = try await repository.fetchLaunches(with: request)

            return launches
        } catch {
            throw FetchLastLaunchUseCaseError.forward(error)
        }
    }

    /// Make `QueryRequest` for last launch
    private func makeQueryRequest(rocketId: String) -> QueryRequest {
        let date = Date()
        let dateFormatter = ISO8601DateFormatter()
        let formattedDate = dateFormatter.string(from: date)

        let options = PaginationOptions(limit: 1)

        return QueryRequest(
            filter: [
                "rocket": rocketId,
                "date_utc": [
                    "$lte": formattedDate
                ],
                "upcoming": false
            ],
            options: options
        )
    }
}
