//
//  FetchRocketsUseCaseMock.swift
//  SwiftShowcaseTests
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import SpaceXDomain

final class FetchRocketsUseCaseMock: FetchRocketsUseCase {

    private(set) var executeCalled = false
    var executeReturn = Just<[Rocket]>([]).setFailureType(to: FetchRocketsUseCaseError.self).eraseToAnyPublisher()

    func execute() -> AnyPublisher<[Rocket], FetchRocketsUseCaseError> {
        executeCalled = true
        return executeReturn
    }
}
