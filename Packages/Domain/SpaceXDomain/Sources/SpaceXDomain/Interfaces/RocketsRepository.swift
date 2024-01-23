//
//  RocketsRepository.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Combine

/// A protocol defining the requirements for a repository that handles fetching rocket data.
public protocol RocketsRepository {
    /// Fetches a list of rockets.
    ///
    /// - Returns: An `AnyPublisher` that emits an array of `Rocket` objects or an `Error`.
    func fetchRockets() -> AnyPublisher<[Rocket], Error>

    /// Fetches a specific rocket by its identifier.
    ///
    /// - Parameter id: A `String` representing the unique identifier of the rocket.
    /// - Returns: An `AnyPublisher` that emits one `Rocket` object   or an `Error`.
    func fetchRocket(id: String) -> AnyPublisher<Rocket, Error>
}
