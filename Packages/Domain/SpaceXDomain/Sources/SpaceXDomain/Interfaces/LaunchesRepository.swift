//
//  LaunchesRepository.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

public protocol LaunchesRepository {
    /// Fetches an array of `Launch` for a specific rocket.
    /// - Parameter rocketId: The unique identifier of the rocket.
    func fetchLaunches(for rocketId: String, page: Int, limit: Int) async throws -> Paginated<Launch>
}
