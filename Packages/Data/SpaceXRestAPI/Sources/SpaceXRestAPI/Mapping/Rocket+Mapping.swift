//
//  Rocket+Mapping.swift
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
            firstFlightDate = dateFormatter.date(from: firstFlight) ?? Date()
        }

        return Rocket(
            id: id,
            name: name,
            country: country,
            description: description,
            images: flickrImages,
            firstFlight: firstFlightDate,
            active: active
        )
    }
}
