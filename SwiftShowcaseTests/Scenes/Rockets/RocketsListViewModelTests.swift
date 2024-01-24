//
//  RocketsListViewModelTests.swift
//  SwiftShowcaseTests
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import SpaceXDomain
import XCTest

@testable import SwiftShowcase

@MainActor
final class RocketsListViewModelTests: XCTestCase {
    private var fetchRocketsUseCaseMock: FetchRocketsUseCaseMock!
    private var viewModel: RocketsListViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        fetchRocketsUseCaseMock = FetchRocketsUseCaseMock()
        viewModel = RocketsListViewModel(fetchRocketsUseCase: fetchRocketsUseCaseMock)
    }

    override func tearDownWithError() throws {
        fetchRocketsUseCaseMock = nil
        viewModel = nil
        cancellables.removeAll()
    }

    func test_LoadRockets_Success() {
        // Arrange
        let rockets = Rocket.stubs
        let expectedState = RocketsListViewModel.State.finished(rockets)

        fetchRocketsUseCaseMock.executeReturn = Just(rockets)
            .setFailureType(to: FetchRocketsUseCaseError.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "ViewModel should load rockets and update state to .finished")
        var receivedState: RocketsListViewModel.State?

        // Act
        viewModel.loadSubject.send(())

        // Assert
        viewModel.$state
            .dropFirst()
            .sink { state in
                receivedState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(fetchRocketsUseCaseMock.executeCalled)
        XCTAssertEqual(receivedState, expectedState)
    }

    func test_LoadRockets_Empty() {
        // Arrange
        let expectedState = RocketsListViewModel.State.empty

        fetchRocketsUseCaseMock.executeReturn = Just([])
            .setFailureType(to: FetchRocketsUseCaseError.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "ViewModel should load rockets and update state to .empty")
        var receivedState: RocketsListViewModel.State?

        // Act
        viewModel.loadSubject.send(())

        // Assert
        viewModel.$state
            .dropFirst()
            .sink { state in
                receivedState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(fetchRocketsUseCaseMock.executeCalled)
        XCTAssertEqual(receivedState, expectedState)
    }

    func test_LoadRockets_Failure() {
        // Arrange
        let expectedError = FetchRocketsUseCaseError.invalid
        fetchRocketsUseCaseMock.executeReturn = Fail(error: expectedError)
            .eraseToAnyPublisher()

        let expectedState = RocketsListViewModel.State.error(expectedError.localizedDescription)
        let expectation = XCTestExpectation(description: "ViewModel should handle error and update state to .error")
        var receivedState: RocketsListViewModel.State?

        // Act
        viewModel.loadSubject.send(())

        // Assert
        viewModel.$state
            .dropFirst()
            .sink { state in
                receivedState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(fetchRocketsUseCaseMock.executeCalled)
        XCTAssertEqual(receivedState, expectedState)
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
