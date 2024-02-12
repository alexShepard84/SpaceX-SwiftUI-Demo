//
//  RocketDTO.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation

struct RocketDTO: Codable {
    let id: String
    let height, diameter: Dimension
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [URL]
    let name, type: String
    let active: Bool
    let stages, boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String?
    let country, company: String
    let wikipedia: URL
    let description: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia, description, id
    }

    struct Dimension: Codable {
        let meters: Double?
        let feet: Double?
    }

    struct FirstStage: Codable {
        let thrustSeaLevel, thrustVacuum: Thrust
        let reusable: Bool
        let engines, fuelAmountTons: Double
        let burnTimeSec: Int?

        enum CodingKeys: String, CodingKey {
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
            case reusable, engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTimeSec = "burn_time_sec"
        }
    }

    struct SecondStage: Codable {
        let thrust: Thrust
        let payloads: Payloads
        let reusable: Bool
        let engines, fuelAmountTons: Double
        let burnTimeSec: Int?

        enum CodingKeys: String, CodingKey {
            case thrust, payloads, reusable, engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTimeSec = "burn_time_sec"
        }
    }

    struct Payloads: Codable {
        let compositeFairing: CompositeFairing
        let option1: String

        enum CodingKeys: String, CodingKey {
            case compositeFairing = "composite_fairing"
            case option1 = "option_1"
        }
    }

    struct CompositeFairing: Codable {
        let height, diameter: Dimension
    }

    struct Thrust: Codable {
        let kN, lbf: Int
    }

    struct Mass: Codable {
        let kg, lb: Double?
    }

    struct Engines: Codable {
        let isp: ISP
        let thrustSeaLevel, thrustVacuum: Thrust
        let number: Int
        let type, version: String
        let layout: String? // Optional, falls es null sein kann
        let engineLossMax: Int?
        let propellant1, propellant2: String
        let thrustToWeight: Double

        enum CodingKeys: String, CodingKey {
            case isp
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
            case number, type, version, layout
            case engineLossMax = "engine_loss_max"
            case propellant1 = "propellant_1"
            case propellant2 = "propellant_2"
            case thrustToWeight = "thrust_to_weight"
        }
    }

    struct ISP: Codable {
        let seaLevel, vacuum: Int

        enum CodingKeys: String, CodingKey {
            case seaLevel = "sea_level"
            case vacuum
        }
    }

    struct LandingLegs: Codable {
        let number: Int
        let material: String?
    }

    struct PayloadWeight: Codable {
        let id, name: String
        let kg, lb: Double
    }

}
