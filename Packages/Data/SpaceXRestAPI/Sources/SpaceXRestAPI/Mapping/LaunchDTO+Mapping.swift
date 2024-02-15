//
//  LaunchDTO+Mapping.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation
import SpaceXDomain

extension LaunchDTO {
    func toDomain() -> Launch {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: dateUtc)

        return Launch(
            id: id,
            details: details ?? "N/A",
            rocketId: rocket,
            date: date
        )
    }
}
