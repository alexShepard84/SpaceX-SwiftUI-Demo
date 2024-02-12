//
//  Paginated.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

public struct Paginated<T: Identifiable> {
    public var id: String { "\(page)" }
    public let items: [T]
    public let totalDocs: Int
    public let totalPages: Int
    public let page: Int
    public let hasNextPage: Bool
    public let hasPrevPage: Bool

    public init(items: [T], totalDocs: Int, totalPages: Int, page: Int, hasNextPage: Bool, hasPrevPage: Bool) {
        self.items = items
        self.totalDocs = totalDocs
        self.totalPages = totalPages
        self.page = page
        self.hasNextPage = hasNextPage
        self.hasPrevPage = hasPrevPage
    }
}
