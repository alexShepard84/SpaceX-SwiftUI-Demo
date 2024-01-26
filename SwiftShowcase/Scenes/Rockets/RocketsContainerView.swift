//
//  RocketsContainerView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 25.01.24.
//

import SwiftUI

struct RocketsContainerView: View {
    @State private var selectedAPI = 0
    var restViewModel: RocketsListViewModel
    var gqlViewModel: RocketsListViewModel

    var body: some View {
        VStack {
            if selectedAPI == 0 {
                RocketsListView(viewModel: restViewModel)
            } else {
                RocketsListView(viewModel: gqlViewModel)
            }
            Spacer()
            Picker("API Type", selection: $selectedAPI) {
                Text("REST").tag(0)
                Text("GraphQL").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}
