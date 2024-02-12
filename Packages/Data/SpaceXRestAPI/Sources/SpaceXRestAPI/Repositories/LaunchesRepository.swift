//
//  LaunchesRepository.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import OSLog
import SpaceXDomain
import NetworkService

public final class DefaultLaunchesRepository {
    private let networkService: NetworkServiceProtocol
    private let logger = Logger()

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension DefaultLaunchesRepository: LaunchesRepository {
    public func fetchLaunches(for rocketId: String, page: Int = 0, limit: Int = 10) async throws -> Paginated<Launch> {
        logger.info("Fetching launches for rocket ID \(rocketId)")

        do {
            let paginatedResponse: PaginatedResponseWrapper<LaunchDTO> = try await networkService.requestAsync(SpaceXRestAPIRouter.launchesByRocket(id: rocketId, page: page, limit: limit))

            let launches = paginatedResponse.docs.map { $0.toDomain() }

            return Paginated(
                items: launches,
                totalDocs: paginatedResponse.totalDocs,
                totalPages: paginatedResponse.totalPages,
                page: paginatedResponse.page,
                hasNextPage: paginatedResponse.hasNextPage,
                hasPrevPage: paginatedResponse.hasPrevPage
            )
        } catch {
            logger.error("Failed to fetch launches: \(error.localizedDescription)")
            throw error
        }
    }
}
