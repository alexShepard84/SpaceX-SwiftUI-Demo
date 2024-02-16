//
//  Font.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 08.02.24.
//

import SwiftUI

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 60
        case .title: return 48
        case .title2: return 34
        case .title3: return 24
        case .headline, .body: return 18
        case .subheadline, .callout: return 16
        case .footnote: return 14
        case .caption, .caption2: return 12
        @unknown default:
            return 8
        }
    }
}

extension Font {
    static let spaceXLargeTitle = custom(.regular, relativeTo: .largeTitle)
    static let spaceXTitle = custom(.regular, relativeTo: .title)
    static let spaceXTitle2 = custom(.regular, relativeTo: .title2)
    static let spaceXTitle3 = custom(.regular, relativeTo: .title3)
    static let spaceXHeadline = custom(.bold, relativeTo: .headline)
    static let spaceXBody = custom(.regular, relativeTo: .body)
    static let spaceXSubheadline = custom(.regular, relativeTo: .subheadline)
    static let spaceXCallout = custom(.regular, relativeTo: .callout)
    static let spaceXCaption = custom(.regular, relativeTo: .caption)

    static func custom(_ font: DDinFont, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }
}
