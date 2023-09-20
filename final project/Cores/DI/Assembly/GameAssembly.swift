//
//  GameAssembly.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 18/09/23.
//

import Swinject
import SwinjectAutoregistration

class GameAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: -Data
        container.autoregister(GameServiceProtocol.self, initializer: GameService.init).inObjectScope(.container)
        container.autoregister(GameRepositoryProtocol.self, initializer: GameRepository.init).inObjectScope(.container)
        
        // MARK: -HOME
        container.autoregister(HomeUseCase.self, initializer: HomeInteractor.init)
        container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        container.autoregister(HomeViewController.self, initializer: HomeViewController.init)
        
        // MARK: -Detail
        container.autoregister(DetailUseCase.self, initializer: DetailInteractor.init)
        container.autoregister(DetailViewModel.self, initializer: DetailViewModel.init)
        container.autoregister(DetailViewController.self, initializer: DetailViewController.init)
        
        // MARK: -Search
        container.autoregister(SearchViewModel.self, initializer: SearchViewModel.init)
        container.autoregister(SearchViewController.self, initializer: SearchViewController.init)
    }
}
