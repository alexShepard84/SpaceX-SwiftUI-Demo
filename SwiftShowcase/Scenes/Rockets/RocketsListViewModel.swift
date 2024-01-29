//
//  RocketsListViewModel.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 23.01.24.
//

import Combine
import Foundation
import SpaceXDomain

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
    private let sceneFactory: RocketsSceneFactoryProtocol

    init(fetchRocketsUseCase: FetchRocketsUseCase, sceneFactory: RocketsSceneFactoryProtocol) {
        self.fetchRocketsUseCase = fetchRocketsUseCase
        self.sceneFactory = sceneFactory

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

// MARK: - Routing
extension RocketsListViewModel {
    func makeRocketDetailView(_ rocket: Rocket) -> RocketDetailView {
        sceneFactory.makeRocketDetailView(with: rocket)
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
