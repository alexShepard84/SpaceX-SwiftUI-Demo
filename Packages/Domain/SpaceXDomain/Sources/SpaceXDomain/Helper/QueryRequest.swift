//
//  QueryRequest.swift
//
//
//  Created by Alex Schäfer on 13.02.24.
//

/// Encapsulates query filter and options for fetching data.
public struct QueryRequest {
    public let filter: [String: Any]
    public let options: QueryOptions?

    init(filter: [String: Any], options: QueryOptions? = nil) {
        self.filter = filter
        self.options = options
    }
}

/// Defines options for querying data such as pagination and sorting.
public struct QueryOptions {
    public let page: Int
    public let limit: Int
    public let sortAscending: Bool

    init(
        page: Int = 0,
        limit: Int = 10,
        sortAscending: Bool = true
    ) {
        self.page = page
        self.limit = limit
        self.sortAscending = sortAscending
    }
}
