//
//  FetchRocketsUseCase.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Combine
import Foundation

// MARK: - FetchRocketsUseCaseError
public enum FetchRocketsUseCaseError: Error {
    case invalid
    case forward(Error)
}

// MARK: - FetchRocketsUseCase Protocol
public protocol FetchRocketsUseCase {
    /// Fetches an array of `Rocket`
    func execute() -> AnyPublisher<[Rocket], FetchRocketsUseCaseError>
}

// MARK: - FetchRocketsUseCase Default Implementation
public final class DefaultFetchRocketsUseCase: FetchRocketsUseCase {
    private let repository: RocketsRepository

    public init(repository: RocketsRepository) {
        self.repository = repository
    }

    public func execute() -> AnyPublisher<[Rocket], FetchRocketsUseCaseError> {
        repository.fetchRockets()
            .mapError { error in
                FetchRocketsUseCaseError.forward(error)
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - FetchRocketsUseCase Stub Implementation

public final class StubFetchRocketsUseCase: FetchRocketsUseCase {
    public init() {
        // no implementation needed
    }

    public func execute() -> AnyPublisher<[Rocket], FetchRocketsUseCaseError> {
        Just([]).setFailureType(to: FetchRocketsUseCaseError.self).eraseToAnyPublisher()
    }
}
