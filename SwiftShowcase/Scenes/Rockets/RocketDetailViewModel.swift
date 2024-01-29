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

    init(rocket: Rocket) {
        self.rocket = rocket
    }
}
