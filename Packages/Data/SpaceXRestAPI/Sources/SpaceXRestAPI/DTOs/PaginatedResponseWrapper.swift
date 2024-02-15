//
//  PaginatedResponseWrapper.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

struct PaginatedResponseWrapper<T: Decodable>: Decodable {
    let docs: [T]
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
    let pagingCounter: Int
    let hasPrevPage: Bool
    let hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?
}
