//
//  DetailInteractor.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 18/09/23.
//

import RxSwift

protocol DetailUseCase {
    func requestGameDetail(id: Int) -> Observable<Game>
    
    func requestFavoriteList() -> Observable<[Game]>
    func requestCreateFavorite(request: Game) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

class DetailInteractor: DetailUseCase {
    let gameRepository: GameRepositoryProtocol
    let favoriteRepository: FavoriteRepositoryProtocol
    
    let disposedBag = DisposeBag()
    
    init(
        gameRepository: GameRepositoryProtocol,
        favoriteRepository: FavoriteRepositoryProtocol
    ) {
        self.gameRepository = gameRepository
        self.favoriteRepository = favoriteRepository
    }

    func requestGameDetail(id: Int) -> Observable<Game> {
        return Observable.create { observer in
            self.gameRepository.requestGameDetail(id: id).subscribe(onNext: { gameData in
                let game = Game(from: gameData)
                observer.onNext(game)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposedBag)
            
            return Disposables.create()
        }
    }
    
    func requestFavoriteList() -> RxSwift.Observable<[Game]> {
        return Observable.create { observer in
            self.favoriteRepository.requestFavoriteList().subscribe(onNext: { gameDataList in
                let gameList = gameDataList.map { gameData in
                    return Game(from: gameData)
                }
                observer.onNext(gameList)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposedBag)
            
            return Disposables.create()
        }
    }
    
    func requestCreateFavorite(request: Game) -> RxSwift.Observable<String> {
        let requestGameData = GameData(from: request)
        return favoriteRepository.requestCreateFavorite(request: requestGameData)
    }
    
    func requestDeleteFavorite(id: Int) -> RxSwift.Observable<String> {
        return favoriteRepository.requestDeleteFavorite(id: id)
    }
}
