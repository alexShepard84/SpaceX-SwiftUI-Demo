//
//  GQLRocket+Mapping.swift
//
//
//  Created by Alex Schäfer on 25.01.24.
//

import Foundation
import SpaceXDomain

extension RocketsQuery.Data.Rocket {
    func toDomain() -> SpaceXDomain.Rocket {
        return .init(
            id: id ?? "",
            name: name ?? "",
            country: country ?? "",
            description: description ?? "",
            images: [],
            firstFlight: nil,
            active: active ?? false
        )
    }
}
