//
//  RocketDTO+Mapping.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation
import SpaceXDomain

extension RocketDTO {
    func toDomain() -> Rocket {
        var firstFlightDate: Date?
        if let firstFlight {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            firstFlightDate = dateFormatter.date(from: firstFlight)
        }

        let payloadWeights = payloadWeights.map { RocketTechnicalData.PayloadWeightData(
            id: $0.id,
            name: $0.name,
            kg: $0.kg,
            lb: $0.lb
        )}

        let technicalData = RocketTechnicalData(
            heightMeters: height.meters ?? 0,
            heightFeet: height.feet ?? 0,
            diameterMeters: diameter.meters ?? 0,
            diameterFeet: diameter.feet ?? 0,
            massKg: mass.kg ?? 0,
            massLb: mass.lb ?? 0,
            payloadWeights: payloadWeights
        )

        return Rocket(
            id: id,
            name: name,
            country: country,
            description: description,
            images: flickrImages,
            firstFlight: firstFlightDate,
            active: active,
            technicalData: technicalData
        )
    }
}
