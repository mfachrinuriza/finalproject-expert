//
//  HomeInteractor.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import RxSwift

protocol HomeUseCase {
    func requestGameList(totalList: Int) -> Observable<[Game]>
    func requestGameDetail(id: Int) -> Observable<Game>
}

class HomeInteractor: HomeUseCase {
    let gameRepository: GameRepositoryProtocol
    
    let disposedBag = DisposeBag()
    
    init(
        gameRepository: GameRepositoryProtocol
    ) {
        self.gameRepository = gameRepository
    }

    func requestGameList(totalList: Int) -> Observable<[Game]> {
        return Observable.create { observer in
            
            self.gameRepository.requestGameList(totalList: totalList).subscribe(onNext: { gameDataList in
                let gameList = gameDataList.results?.map { gameData in
                    return Game(from: gameData)
                }
                observer.onNext(gameList ?? [])
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposedBag)
            
            return Disposables.create()
        }
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
}
