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
        // TODO: Update RocketsQuery to retrieve technical data
        let technicalData = RocketTechnicalData(
            heightMeters: 0,
            heightFeet: 0,
            diameterMeters: 0,
            diameterFeet: 0,
            massKg: 0,
            massLb: 0,
            payloadWeights: []
        )

        return .init(
            id: id ?? "",
            name: name ?? "",
            country: country ?? "",
            description: description ?? "",
            images: [],
            firstFlight: nil,
            active: active ?? false,
            technicalData: technicalData
        )
    }
}
