import Combine
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

@testable import NetworkService

final class NetworkServiceTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var networkService: NetworkService!

    override func setUp() {
        super.setUp()

        networkService = NetworkService(configuration: .ephemeral)
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        networkService = nil

        super.tearDown()
    }

    func test_Request_Succeed() {
        // Arrange
        let expectedItem: CodableItem = CodableItem(id: "1234", name: "test")

        var receivedItem: CodableItem?

        let router = MockRouter()
        let jsonData = try! JSONEncoder().encode(expectedItem)

        stub(condition: isHost("api.example.com")) { _ in
            // Return a successful response with your test data
            HTTPStubsResponse(
                data: jsonData,
                statusCode: 200,
                headers: router.headers
            )
        }

        let expectation = self.expectation(description: "Wait for Request")

        // Execute
        networkService.request(router)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Request failed with error: \(error)")
                    }
                },
                receiveValue: { item in
                    receivedItem = item
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(receivedItem, expectedItem)
    }

    func test_RequestArray_Succeed() {
        // Arrange
        let expectedItems = [
            CodableItem(id: "1", name: "test1"),
            CodableItem(id: "2", name: "test2"),
            CodableItem(id: "3", name: "test3"),
        ]

        var receivedItems: [CodableItem] = []

        let router = MockRouter()
        let jsonData = try! JSONEncoder().encode(expectedItems)

        stub(condition: isHost("api.example.com")) { _ in
            HTTPStubsResponse(
                data: jsonData,
                statusCode: 200,
                headers: router.headers
            )
        }

        let expectation = self.expectation(description: "Wait for Request")

        // Execute
        networkService.request(router)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Request failed with error: \(error)")
                    }
                },
                receiveValue: { items in
                    receivedItems = items
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(receivedItems, expectedItems)
    }

    func test_Request_Failure() {
        stub(condition: isHost("api.example.com")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.badServerResponse.rawValue,
                userInfo: nil
            )

            return HTTPStubsResponse(error: error)
        }


        let expectation = self.expectation(description: "RequestFailure")

        var receivedError: Error?

        networkService.request(MockRouter())
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                }, 
                receiveValue: { (_: CodableItem) in
                    XCTFail("Request should not succeed")
                }
            ).store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertNotNil(receivedError)
    }
}

/// Generic struct that implements `Codable`
fileprivate struct CodableItem: Codable, Equatable {
    let id: String
    let name: String
}

/// Mock of a `Routable`
fileprivate struct MockRouter: Routable {
    var baseUrl: URL {
        URL(string: "https://api.example.com")!
    }

    var path: String {
        "test"
    }

    var httpMethod: String {
        HTTPMethod.get.rawValue
    }

    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
}
