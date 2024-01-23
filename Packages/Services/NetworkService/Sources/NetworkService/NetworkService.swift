//
//  NetworkService.swift
//
//
//  Created by Alex Schäfer on 16.01.24.
//

import Combine
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol NetworkServiceProtocol {
    /// Performs a network request and returns a publisher emitting the decoded response.
    /// - Parameter route: The `Routable` resource to request.
    func request<T: Decodable>(_ route: Routable) -> AnyPublisher<T, Error>
}

public final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    /// Initializes a new network service with a specified `URLSessionConfiguration`.
    /// - Parameter configuration: The configuration for the URL session. Defaults to `.default`.
    public init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
}

// MARK: - Public API
public extension NetworkService {
    func request<T>(_ route: Routable) -> AnyPublisher<T, Error> where T : Decodable {
        guard let request = buildRequest(for: route) else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkServiceError.requestFailed
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Privates
private extension NetworkService {
    /// Builds a `URLRequest` from a given `Routable`.
    func buildRequest(for route: Routable) -> URLRequest? {
        guard let url = route.absoluteUrl else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.httpMethod

        for header in route.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }
}

