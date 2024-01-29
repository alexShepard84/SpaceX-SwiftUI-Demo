//
//  RocketDetailView.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 26.01.24.
//

import SwiftUI

struct RocketDetailView: View {
    @StateObject var viewModel: RocketDetailViewModel

    var body: some View {
        Text(viewModel.rocket.name)
    }
}

//#Preview {
//    RocketDetailView()
//}
