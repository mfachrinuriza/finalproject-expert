//
//  FavoriteRepository.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import RxSwift

protocol FavoriteRepositoryProtocol {
    func requestFavoriteList() -> Observable<[GameData]>
    func requestFavoriteDetail(id: Int) -> Observable<GameData>
    func requestCreateFavorite(request: GameData) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

class FavoriteRepository: NSObject {
        
    let storage: FavoriteStorageProtocol
    
    static let sharedInstance = {
        let storage = FavoriteStorage.sharedInstance
        return FavoriteRepository(storage: storage)
    }()
    
    init(storage: FavoriteStorageProtocol) {
        self.storage = storage
    }
}

extension FavoriteRepository: FavoriteRepositoryProtocol {
    func requestFavoriteList() -> RxSwift.Observable<[GameData]> {
        self.storage.requestFavoriteList()
    }
    
    func requestFavoriteDetail(id: Int) -> RxSwift.Observable<GameData> {
        self.storage.requestFavoriteDetail(id: id)
    }
    
    func requestCreateFavorite(request: GameData) -> RxSwift.Observable<String> {
        self.storage.requestCreateFavorite(request: request)
    }
    
    func requestDeleteFavorite(id: Int) -> RxSwift.Observable<String> {
        self.storage.requestDeleteFavorite(id: id)
    }
}
