//
//  QueryRequest.swift
//
//
//  Created by Alex Schäfer on 13.02.24.
//

/// Encapsulates query filter and options for fetching data.
public struct QueryRequest {
    public let filter: [String: Any]
    public let options: PaginationOptions?

    init(filter: [String: Any], options: PaginationOptions? = nil) {
        self.filter = filter
        self.options = options
    }
}

/// Defines options for querying data such as pagination and sorting.

public struct PaginationOptions {
    public let page: Int
    public let limit: Int
    public let sortByField: String
    public let sort: SortOption

    public enum SortOption: String {
        case asc, desc
    }

    init(
        page: Int = 1,
        limit: Int = 10,
        sortByField: String = "date_utc",
        sort: SortOption = .desc
    ) {
        self.page = page
        self.limit = limit
        self.sortByField = sortByField
        self.sort = sort
    }
}
