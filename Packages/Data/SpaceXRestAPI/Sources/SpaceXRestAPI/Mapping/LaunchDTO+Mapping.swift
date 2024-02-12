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
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: dateLocal) ?? Date()

        return Launch(
            id: id,
            details: details ?? "N/A",
            rocketId: rocket,
            date: date
        )
    }
}
