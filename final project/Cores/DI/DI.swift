//
//  DI.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 18/09/23.
//

import Swinject

protocol DIProtocol {
    static func get<T>(_ type: T.Type, name: String?) -> T
}

class DI: DIProtocol {
    static let container = Container()
    static let assembler = Assembler(
        [
            // Modules
            GameAssembly(),
            FavoriteAssembly(),
            ProfileAssembly(),
            MainAssembly(),
        ],
        container: DI.container
    )
    
    static func get<T>(_ type: T.Type, name: String? = nil) -> T {
        DI.assembler.resolver.resolve(T.self, name: name)!
    }
}

