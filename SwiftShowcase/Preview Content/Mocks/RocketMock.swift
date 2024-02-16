//
//  RocketMock.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 31.01.24.
//
// swiftlint:disable all

import Foundation
import SpaceXDomain

extension Rocket {
    static var mock: Rocket {
        .init(
            id: "1234",
            name: "Falco Heavy",
            country: "US",
            description: """
Falcon Heavy is composed of three reusable Falcon 9 nine-engine cores whose 27 Merlin engines together generate 
more than 5 million pounds of thrust at liftoff,
equal to approximately eighteen 747 aircraft.
As one of the world’s most powerful operational rockets, Falcon Heavy can lift nearly 64 metric tons (141,000 lbs) to orbit.
""",
            images: [
                URL(string: "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg")!,
                URL(string: "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg")!,
                URL(string: "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg")!,
                URL(string: "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg")!
            ],
            active: true,
            technicalData: RocketTechnicalData.mock
        )
    }
}

extension RocketTechnicalData {
    static var mock: RocketTechnicalData {
        .init(
            heightMeters: 70,
            heightFeet: 229.6,
            diameterMeters: 12.2,
            diameterFeet: 39.9,
            massKg: 1420788,
            massLb: 3125735,
            payloadWeights: [
                .init(id: "leo", name: "Low Earth Orbit", kg: 63800, lb: 140660),
                .init(id: "gto", name: "Geosynchronous Transfer Orbit", kg: 26700, lb: 58860),
                .init(id: "mars", name: "Mars Orbit", kg: 16800, lb: 37040),
                .init(id: "pluto", name: "Pluto Orbit", kg: 3500, lb: 7720)
            ]
        )
    }
}
