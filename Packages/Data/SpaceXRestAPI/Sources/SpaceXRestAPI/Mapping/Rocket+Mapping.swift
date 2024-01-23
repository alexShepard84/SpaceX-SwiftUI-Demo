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
        .init(
            id: id,
            name: name,
            country: country,
            description: description,
            images: flickrImages,
            firstFlight: firstFlight,
            active: active
        )
    }
}
