//
//  AnimatableNumberModifier.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 15.02.24.
//

import SwiftUI

/// Credits to https://stefanblos.com/posts/animating-number-changes/
struct AnimatableNumberModifier: AnimatableModifier {
    var number: Int

    var animatableData: Int {
        get { number }
        set { number = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(number)")
            )
    }
}

extension View {
    func animatingOverlay(for number: Int) -> some View {
        modifier(AnimatableNumberModifier(number: number))
    }
}

extension Int: VectorArithmetic {
    mutating public func scale(by rhs: Double) {
        self = Int(Double(self) * rhs)
    }

    public var magnitudeSquared: Double {
        Double(self * self)
    }
}
