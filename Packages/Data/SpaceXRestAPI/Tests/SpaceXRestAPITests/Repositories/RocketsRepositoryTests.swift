//
//  RocketsRepositoryTests.swift
//  
//
//  Created by Alex Schäfer on 24.01.24.
//
import Combine
import SpaceXDomain
import XCTest

@testable import SpaceXRestAPI

final class RocketsRepositoryTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var repository: DefaultRocketsRepository!

    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        repository = DefaultRocketsRepository(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
        repository = nil
        cancellables.removeAll()
    }

    func test_FetchRockets_Success() {
        // Arrange
        mockNetworkService.jsonFileName = "Rockets"
        let expectedRocketsCount = 2

        var receivedRockets: [Rocket] = []

        let expectation = self.expectation(description: "Fetch rockets")

        // Act
        repository.fetchRockets()
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
        XCTAssertEqual(receivedRockets.count, expectedRocketsCount)
    }

    func test_FetchRocket_Success() {
        // Arrange
        let rocketId = "5e9d0d95eda69974db09d1ed"
        mockNetworkService.jsonFileName = "Rocket"
        let expectedRocket = Rocket(
            id: rocketId,
            name: "Falcon Heavy",
            country: "United States",
            description: "Test Rocket", 
            images: [],
            active: true
        )

        var receivedRocket: Rocket?
        let expectation = self.expectation(description: "Fetch rocket successfully")

        // Act
        repository.fetchRocket(id: rocketId)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Request failed with error: \(error)")
                    }
                },
                receiveValue: { rocket in
                    receivedRocket = rocket
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(receivedRocket, expectedRocket)
    }
}
