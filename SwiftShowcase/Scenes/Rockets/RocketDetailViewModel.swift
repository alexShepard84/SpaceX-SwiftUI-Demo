//
//  RocketDetailViewModel.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import Combine
import Foundation

import SpaceXDomain

@MainActor
final class RocketDetailViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case finished(RocketDetailViewModel.Output)
    }

    // MARK: - Dependencies
    private let fetchLastLaunchUseCase: FetchLastLaunchUseCase
    private let rocket: Rocket

    // MARK: - Output
    @Published private(set) var output: Output

    init(rocket: Rocket, fetchLastLaunchUseCase: FetchLastLaunchUseCase) {
        self.rocket = rocket
        self.fetchLastLaunchUseCase = fetchLastLaunchUseCase

        self.output = Output(rocket: rocket)
    }
}

// MARK: -
extension RocketDetailViewModel {
    func loadLaunches() {
        Task {
            do {
                let fetchedLaunches = try await fetchLastLaunchUseCase.execute(rocketId: rocket.id)
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        return
                    }
                    let lastLaunch = fetchedLaunches.items.first
                    let output = Output(
                        rocket: self.rocket,
                        lastLaunch: lastLaunch,
                        totalLaunches: fetchedLaunches.totalDocs
                    )
                    self.output = output
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}

extension RocketDetailViewModel {
    struct Output: Equatable {
        var rocket: Rocket
        var lastLaunch: Launch?
        var totalLaunches: Int?

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

        var formattedLaunchDate: String {
            guard let date = lastLaunch?.date else {
                return ""
            }

            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            return formatter.string(from: date)
        }
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
