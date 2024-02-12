//
//  NetworkService.swift
//
//
//  Created by Alex Schäfer on 16.01.24.
//

import Combine
import Foundation
import OSLog

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

    /// Performs an asynchronous network request and returns the decoded response.
    /// - Parameter route: The `Routable` resource to request.
    /// - Returns: The decoded response of type `T`.
    /// - Throws: An error if the request fails or the response cannot be decoded.
    func requestAsync<T: Decodable>(_ route: Routable) async throws -> T
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
        // TODO: Implement Logger / Improve Error Handling

        guard let request = buildRequest(for: route) else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .handleEvents(
                receiveOutput: { data, response in
                    if let httpResponse = response as? HTTPURLResponse {
                        os_log("Response: %@", type: .debug, httpResponse.debugDescription)
                    }
                }, 
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        os_log("Request failed: %@", type: .error, error.localizedDescription)
                    }
            })
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkServiceError.requestFailed
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    os_log("Decoding successful", type: .info)
                case .failure(let error):
                    os_log("Decoding failed", type: .error, error.localizedDescription)
                }
            })
            .eraseToAnyPublisher()
    }

    /// Asynchronously fetches data from the network and decodes it to the specified type.
    func requestAsync<T>(_ route: Routable) async throws -> T where T : Decodable {
        guard let request = buildRequest(for: route) else {
            throw NetworkServiceError.invalidURL
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkServiceError.requestFailed
        }

        os_log("Response: %@", type: .debug, httpResponse.debugDescription)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            os_log("Decoding failed", type: .error, error.localizedDescription)

            throw NetworkServiceError.decodingFailed
        }
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

        if let body = route.body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                urlRequest.httpBody = jsonData
            } catch {
                os_log("Encoding failed", type: .error, error.localizedDescription)
                return nil
            }
        }

        return urlRequest
    }
}

