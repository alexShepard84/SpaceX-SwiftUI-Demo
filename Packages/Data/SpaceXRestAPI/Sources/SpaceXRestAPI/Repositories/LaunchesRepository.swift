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
    public func fetchLaunches(with request: QueryRequest?) async throws -> Paginated<Launch> {

        let queryFilter = request?.filter
        let queryOptions = request?.options.map {
            QueryOptions(
                page: $0.page,
                limit: $0.limit,
                sort: ["date_utc": $0.sortAscending ? "asc" : "desc"]
            )
        }

        do {
            let paginatedResponse: PaginatedResponseWrapper<LaunchDTO> = try await networkService.requestAsync(SpaceXRestAPIRouter.launchesQuery(queryFilter, queryOptions))

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
