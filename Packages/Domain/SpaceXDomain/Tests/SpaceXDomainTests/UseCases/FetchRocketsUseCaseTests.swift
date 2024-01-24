//
//  FetchRocketsUseCaseTests.swift
//
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import XCTest

@testable import SpaceXDomain

final class FetchRocketsUseCaseTests: XCTestCase {
    private var repositoryMock: RocketsRepositoryMock!
    private var useCase: DefaultFetchRocketsUseCase!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        repositoryMock = RocketsRepositoryMock()
        useCase = DefaultFetchRocketsUseCase(repository: repositoryMock)
    }

    override func tearDownWithError() throws {
        repositoryMock = nil
        useCase = nil
        cancellables.removeAll()
    }

    func testExecute_Success() {
        // Arrange
        let expectedRockets = Rocket.stubs
        repositoryMock.fetchRocketsReturn = Just(expectedRockets).setFailureType(to: Error.self).eraseToAnyPublisher()

        var receivedRockets: [Rocket] = []
        let expectation = self.expectation(description: "Fetch rockets successfully")

        // Act
        useCase.execute()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Request failed with error: \(error)")
                    }
                },
                receiveValue: { rockets in
                    receivedRockets = rockets
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(receivedRockets, expectedRockets)
        XCTAssertTrue(repositoryMock.fetchRocketsCalled)
    }

    func testExecute_Failure() {
        // Arrange
        let expectedError = FetchRocketsUseCaseError.forward(TestError.dummy)
        repositoryMock.fetchRocketsReturn = Fail(error: TestError.dummy).eraseToAnyPublisher()

        var receivedError: FetchRocketsUseCaseError?
        let expectation = self.expectation(description: "Fetch rockets fails")

        // Act
        useCase.execute()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(receivedError, expectedError)
        XCTAssertTrue(repositoryMock.fetchRocketsCalled)
    }
}

extension Rocket {
    static var stubs: [Rocket] = [
        .init(
            id: "1",
            name: "Falcon 1",
            country: "US",
            description: "Test Rocket",
            images: [],
            active: true
        ),
        .init(
            id: "2",
            name: "Falcon 9",
            country: "US",
            description: "Test Rocket 2",
            images: [],
            active: true
        )
    ]
}

extension FetchRocketsUseCaseError: Equatable {
    public static func == (lhs: FetchRocketsUseCaseError, rhs: SpaceXDomain.FetchRocketsUseCaseError) -> Bool {
        switch (lhs, rhs) {
        case (.invalid, .invalid):
            return true
        case (.forward(let lhsError), .forward(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

enum TestError: Error {
    case dummy
}
