//
//  ProfileAssembly.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import Swinject
import SwinjectAutoregistration

class ProfileAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(ProfileViewModel.self, initializer: ProfileViewModel.init)
        container.autoregister(ProfileViewController.self, initializer: ProfileViewController.init)
        
        container.autoregister(ProfileEditViewModel.self, initializer: ProfileEditViewModel.init)
        container.autoregister(ProfileEditViewController.self, initializer: ProfileEditViewController.init)
    }
}
