//
//  SwiftShowcaseApp.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 19.01.24.
//

import SwiftData
import SwiftUI

@main
struct SwiftShowcaseApp: App {
    @StateObject private var diContainer = DIContainer()

    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                ContentView()
                    .environment(\.windowSize, proxy.size)
                    .environmentObject(diContainer.rocketsSceneFactory)
            }
        }
    }
}
