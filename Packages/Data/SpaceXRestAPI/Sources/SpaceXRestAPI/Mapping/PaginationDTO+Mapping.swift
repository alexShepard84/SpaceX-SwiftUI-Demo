//
//  File.swift
//  
//
//  Created by Alex Schäfer on 14.02.24.
//

import Foundation
import SpaceXDomain

extension PaginationOptions {
    var asDTO: PaginationOptionsDTO {
        .init(
            page: page, 
            limit: limit,
            sort: [
                sortByField: sort.rawValue
            ]
        )
    }
}
