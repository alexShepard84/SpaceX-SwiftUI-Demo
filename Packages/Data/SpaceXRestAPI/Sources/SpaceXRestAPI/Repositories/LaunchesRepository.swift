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
        let queryOptions = request?.options?.asDTO

        do {
            let query = SpaceXRestAPIRouter.launchesQuery(queryFilter, queryOptions)
            let paginatedResponse: PaginatedResponseWrapper<LaunchDTO> = try await networkService.requestAsync(query)

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
