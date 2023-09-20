//
//  ModuleBuilder.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit

class ModuleBuilder: NSObject {
    
    class func getView(module: ModuleEnum) -> UIViewController {
        switch module {
        case .main:
            let mainViewController = DI.get(MainViewController.self)
            return mainViewController
        case .home:
            let homeViewController = DI.get(HomeViewController.self)
            return homeViewController
        case .favorite:
            let favoriteViewController = DI.get(FavoriteViewController.self)
            return favoriteViewController
        case .detail(let gameId):
            let detailViewController = DI.get(DetailViewController.self)
            detailViewController.gameId = gameId
            return detailViewController
        case .profile:
            let profileViewController = DI.get(ProfileViewController.self)
            return profileViewController
        case .profileEdit:
            let profileEditViewController = DI.get(ProfileEditViewController.self)
            return profileEditViewController
        case .search:
            let searchViewController = DI.get(SearchViewController.self)
            return searchViewController
        }
    }
}
