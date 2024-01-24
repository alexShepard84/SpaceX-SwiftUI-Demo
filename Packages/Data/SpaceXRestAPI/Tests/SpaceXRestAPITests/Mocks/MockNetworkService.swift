//
//  MockNetworkService.swift
//
//
//  Created by Alex Schäfer on 24.01.24.
//

import Combine
import Foundation
import NetworkService

final class MockNetworkService: NetworkServiceProtocol {
    var jsonFileName: String?
    var error: Error?

    func request<T>(_ route: Routable) -> AnyPublisher<T, Error> where T : Decodable {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let data = loadJSONData(),
              let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            return Fail(error: NetworkServiceError.decodingFailed).eraseToAnyPublisher()
        }

        return Just(decodedData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

private extension MockNetworkService {
    func loadJSONData() -> Data? {
        guard let fileName = jsonFileName,
              let url = Bundle.module.url(forResource: jsonFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
