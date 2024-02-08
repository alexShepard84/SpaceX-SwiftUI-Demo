//
//  RocketDetailViewModel.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import Combine
import Foundation

import SpaceXDomain

final class RocketDetailViewModel: ObservableObject {
    let rocket: Rocket

    var formattedHeight: String {
        let meters = rocket.technicalData.heightMeters.lengthFormatter(unit: .meters)
        let feet = rocket.technicalData.heightFeet.lengthFormatter(unit: .feet)
        return "\(meters) / \(feet)"
    }

    var formattedDiameter: String {
        let meters = rocket.technicalData.diameterMeters.lengthFormatter(unit: .meters)
        let feet = rocket.technicalData.diameterFeet.lengthFormatter(unit: .feet)
        return "\(meters) / \(feet)"
    }

    var formattedMass: String {
        let kg = rocket.technicalData.massKg.massFormatter(unit: .kilograms)
        let lb = rocket.technicalData.massLb.massFormatter(unit: .pounds)
        return "\(kg) / \(lb)"
    }

    var formattedPayloadWeights: [PayloadWeight] {
        rocket.technicalData.payloadWeights.map {
            let kg = $0.kg.massFormatter(unit: .kilograms)
            let lb = $0.lb.massFormatter(unit: .pounds)
            return .init(
                id: $0.id,
                name: $0.name,
                value: "\(kg) / \(lb)"
            )
        }
    }

    // TODO: Add Launces UseCase
    init(rocket: Rocket) {
        self.rocket = rocket
    }
}

// MARK: - PayloadWeight
extension RocketDetailViewModel {
    struct PayloadWeight: Identifiable {
        let id: String
        let name: String
        let value: String
    }
}
