//
//  LaunchesRepository.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

public protocol LaunchesRepository {
    /// Fetches launches based on the provided query request.
    /// - Parameter request: An optional `QueryRequest` containing filter and options.
    /// - Returns: A `Paginated` object containing `Launch` entities.
    func fetchLaunches(with request: QueryRequest?) async throws -> Paginated<Launch>
}
