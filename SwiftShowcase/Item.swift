//
//  Item.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 19.01.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
