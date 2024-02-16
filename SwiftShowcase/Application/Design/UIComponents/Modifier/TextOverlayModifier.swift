//
//  TextOverlayModifier.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 16.02.24.
//

import SwiftUI

/// A modifier that overlays a linear gradient and text on any View.
///
/// This modifier applies a linear gradient overlay on top of a view, typically an image,
/// and then overlays text at a specified alignment. The gradient starts clear and transitions
/// to a more opaque black, creating a shaded effect that makes the text more readable
/// against varying image backgrounds.
struct TextOverlayModifier: ViewModifier {
    var text: String
    var font: Font = .spaceXTitle
    var textColor: Color = .white
    var padding: CGFloat = 8
    var alignment: Alignment = .bottomLeading

    func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.3), .black.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .overlay(alignment: alignment) {
                Text(text)
                    .font(font)
                    .padding(padding)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
    }
}

extension View {
    /// Applies a text overlay with a gradient background to the view.
    ///
    /// Use this modifier to add a text overlay with a gradient to any view, typically an image.
    /// This can enhance readability of text when overlaying on varied or complex backgrounds.
    ///
    /// - Parameters:
    ///   - text: The text to be displayed on top of the image.
    ///   - font: The font used for the text. Defaults to `.spaceXTitle`.
    ///   - textColor: The color of the text. Defaults to white.
    ///   - padding: The padding around the text. Defaults to 8 points.
    ///   - alignment: The alignment of the text within the view. Defaults to `.bottomLeading`.
    /// - Returns: A modified view with the text overlay.
    func textOverlay(text: String, font: Font = .spaceXTitle, textColor: Color = .white, padding: CGFloat = 8, alignment: Alignment = .bottomLeading) -> some View {
        self.modifier(TextOverlayModifier(text: text, font: font, textColor: textColor, padding: padding, alignment: alignment))
    }
}
