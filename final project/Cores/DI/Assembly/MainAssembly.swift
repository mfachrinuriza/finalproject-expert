//
//  MainAssembly.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import Swinject
import SwinjectAutoregistration

class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(MainViewController.self, initializer: MainViewController.init)
    }
}
