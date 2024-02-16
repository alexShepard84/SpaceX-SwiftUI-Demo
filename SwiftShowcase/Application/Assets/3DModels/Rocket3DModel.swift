//
//  Rocket3DModel.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 16.02.24.
//

import Foundation

enum Rocket3DModel: String {
    case falcon9 = "5e9d0d95eda69973a809d1ec"
    case falconHeavy = "5e9d0d95eda69974db09d1ed"
    case starship = "5e9d0d96eda699382d09d1ee"

    var fileName: String {
        switch self {
        case .falcon9:
            return "Falcon9.usdz"
        case .falconHeavy:
            return "FalconHeavy.usdz"
        case .starship:
            return "Starship.usdz"
        }
    }

    static func model(for rocketId: String) -> String? {
        return Rocket3DModel(rawValue: rocketId)?.fileName
    }
}
