//
//  Rocket.swift
//
//
//  Created by Alex Schäfer on 23.01.24.
//

import Foundation

/// Entity `
public struct Rocket: Equatable {
    public let id: String
    public let name: String
    public let country: String
    public let description: String
    public let images: [URL]
    public let firstFlight: Date?
    public let active: Bool

    public init(id: String, name: String, country: String, description: String, images: [URL], firstFlight: Date? = nil, active: Bool) {
        self.id = id
        self.name = name
        self.country = country
        self.description = description
        self.images = images
        self.firstFlight = firstFlight
        self.active = active
    }
}
