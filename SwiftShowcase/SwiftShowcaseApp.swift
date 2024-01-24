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
    var diContainer = DIContainer()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // TODO: Setup Navigation
//            ContentView()
            RocketsListView(viewModel: RocketsListViewModel(fetchRocketsUseCase: diContainer.fetchRocketsUseCase))
        }
        .modelContainer(sharedModelContainer)
    }
}
