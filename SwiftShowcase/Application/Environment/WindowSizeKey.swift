//
//  WindowSizeKey.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 15.02.24.
//

import SwiftUI

private struct WindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var windowSize: CGSize {
        get { self[WindowSizeKey.self] }
        set { self[WindowSizeKey.self] = newValue }
    }
}
