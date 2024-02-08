//
//  Rocket.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation

/// Entity `Rocket` 
public struct Rocket: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let country: String
    public let description: String
    public let images: [URL]
    public let firstFlight: Date?
    public let active: Bool
    public let technicalData: RocketTechnicalData

    public init(
        id: String,
        name: String,
        country: String,
        description: String,
        images: [URL],
        firstFlight: Date? = nil,
        active: Bool,
        technicalData: RocketTechnicalData
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.description = description
        self.images = images
        self.firstFlight = firstFlight
        self.active = active
        self.technicalData = technicalData
    }
}

/// Entity `RocketTechnicalData`
public struct RocketTechnicalData: Equatable {
    public let heightMeters: Double
    public let heightFeet: Double
    public let diameterMeters: Double
    public let diameterFeet: Double
    public let massKg: Double
    public let massLb: Double
    public let payloadWeights: [PayloadWeightData]

    public struct PayloadWeightData: Equatable {
        public let id: String
        public let name: String
        public let kg: Double
        public let lb: Double

        public init(id: String, name: String, kg: Double, lb: Double) {
            self.id = id
            self.name = name
            self.kg = kg
            self.lb = lb
        }
    }

    public init(
        heightMeters: Double,
        heightFeet: Double,
        diameterMeters: Double,
        diameterFeet: Double,
        massKg: Double,
        massLb: Double,
        payloadWeights: [RocketTechnicalData.PayloadWeightData]
    ) {
        self.heightMeters = heightMeters
        self.heightFeet = heightFeet
        self.diameterMeters = diameterMeters
        self.diameterFeet = diameterFeet
        self.massKg = massKg
        self.massLb = massLb
        self.payloadWeights = payloadWeights
    }
}
