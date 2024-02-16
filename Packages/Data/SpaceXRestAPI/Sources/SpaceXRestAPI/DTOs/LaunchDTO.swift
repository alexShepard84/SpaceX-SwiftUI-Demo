//
//  LaunchDTO.swift
//
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

struct LaunchDTO: Codable {
    let id: String
    let flightNumber: Int
    let name: String
    let dateUtc: String
    let dateUnix: TimeInterval
    let dateLocal: String
    let datePrecision: DatePrecision
    let staticFireDateUtc: String?
    let staticFireDateUnix: TimeInterval?
    let tdb: Bool?
    let net: Bool
    let window: Int?
    let rocket: String?
    let success: Bool?
    let failures: [Failure]
    let upcoming: Bool
    let details: String?
    let fairings: Fairings?
    let crew: [CrewMember]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String?
    let cores: [Core]
    let links: Links
    let autoUpdate: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case flightNumber = "flight_number"
        case name
        case dateUtc = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case staticFireDateUtc = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tdb
        case net
        case window
        case rocket
        case success
        case failures
        case upcoming
        case details
        case fairings
        case crew
        case ships
        case capsules
        case payloads
        case launchpad
        case cores
        case links
        case autoUpdate = "auto_update"
    }

    enum DatePrecision: String, Codable {
        case half, quarter, year, month, day, hour
    }

    struct Failure: Codable {
        let time: Int
        let altitude: Int?
        let reason: String
    }

    struct Fairings: Codable {
        let reused: Bool?
        let recoveryAttempt: Bool?
        let recovered: Bool?
        let ships: [String]

        enum CodingKeys: String, CodingKey {
            case reused
            case recoveryAttempt = "recovery_attempt"
            case recovered
            case ships
        }
    }

    struct CrewMember: Codable {
        let crew: String?
        let role: String
    }

    struct Core: Codable {
        let core: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landingAttempt: Bool?
        let landingSuccess: Bool?
        let landingType: String?
        let landpad: String?

        enum CodingKeys: String, CodingKey {
            case core
            case flight
            case gridfins
            case legs
            case reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
            case landpad
        }
    }

    struct Links: Codable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr
        let presskit: String?
        let webcast: String?
        let youtubeId: String?
        let article: String?
        let wikipedia: String?

        enum CodingKeys: String, CodingKey {
            case patch
            case reddit
            case flickr
            case presskit
            case webcast
            case youtubeId = "youtube_id"
            case article
            case wikipedia
        }

        struct Patch: Codable {
            let small: String?
            let large: String?
        }

        struct Reddit: Codable {
            let campaign: String?
            let launch: String?
            let media: String?
            let recovery: String?
        }

        struct Flickr: Codable {
            let small: [String]
            let original: [String]
        }
    }
}
