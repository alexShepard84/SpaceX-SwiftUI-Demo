//
//  Routable.swift
//
//
//  Created by Alex Schäfer on 21.01.24.
//

import Foundation

public protocol Routable {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: String { get }
    var absoluteUrl: URL { get }
    var headers: [String: String] { get }
}
