//
//  NetworkServiceError.swift
//
//
//  Created by Alex Schäfer on 21.01.24.
//

public enum NetworkServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case forward(Error)
}
