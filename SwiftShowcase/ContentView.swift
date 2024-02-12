//
//  ContentView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 19.01.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var rocketsSceneFactory: RocketsSceneFactory

    var body: some View {
        rocketsSceneFactory.makeRocketsListView()
    }
}
