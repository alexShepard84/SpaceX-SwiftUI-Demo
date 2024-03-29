//
//  RocketsListViewModel.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 23.01.24.
//

import Combine
import Foundation
import SpaceXDomain

/// `RocketsListViewModel` manages the presentation logic for the `RocketsListView`.
///
/// This view model demonstrates the use of Combine framework with the `FetchRocketsUseCase`.
/// It handles fetching and presenting a list of rockets, managing the state of the view based on the data retrieval process.
/// The view model uses Combine publishers to handle asynchronous data fetching and updates to the UI.
@MainActor
final class RocketsListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case empty
        case finished([Rocket])
        case error(String)
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: Input
    private(set) var loadSubject = PassthroughSubject<Void, Never>()

    // MARK: Output
    @Published private(set) var state: State = .idle

    // MARK: Dependencies
    private let fetchRocketsUseCase: FetchRocketsUseCase

    init(fetchRocketsUseCase: FetchRocketsUseCase) {
        self.fetchRocketsUseCase = fetchRocketsUseCase

        setupSubscriber()
    }
}

// MARK: - Setup
private extension RocketsListViewModel {
    func setupSubscriber() {
        loadSubject
            .handleEvents(
                receiveSubscription: { [weak self] _ in
                    self?.state = .loading
                }
            )
            .flatMap { [weak self] _ -> AnyPublisher<[Rocket], FetchRocketsUseCaseError> in
                self?.fetchRocketsUseCase.execute() ?? Empty().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] rockets in
                    self?.state = rockets.isEmpty ? .empty : .finished(rockets)
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: - Extensions
extension FetchRocketsUseCaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalid:
            // TODO: Add localization
            return "An error occured 😢"
        case .forward(let underlyingError):
            return underlyingError.localizedDescription
        }
    }
}
