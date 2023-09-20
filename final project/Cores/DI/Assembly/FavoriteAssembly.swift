//
//  FavoriteAssembly.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 18/09/23.
//

import Swinject
import SwinjectAutoregistration

class FavoriteAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(FavoriteStorageProtocol.self, initializer: FavoriteStorage.init).inObjectScope(.container)
        container.autoregister(FavoriteRepositoryProtocol.self, initializer: FavoriteRepository.init).inObjectScope(.container)
        
        container.autoregister(FavoriteUseCase.self, initializer: FavoriteInteractor.init)
        container.autoregister(FavoriteViewModel.self, initializer: FavoriteViewModel.init)
        container.autoregister(FavoriteViewController.self, initializer: FavoriteViewController.init)
    }
}
