//
//  DetailViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewModel: BaseViewModel {
    let error: PublishRelay<String> = PublishRelay()
    let shimmering: PublishRelay<Bool> = PublishRelay()
    
    let gameDetail: BehaviorRelay<Game?> = BehaviorRelay(value: nil)
    let isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var detailUseCase: DetailUseCase
    
    init(
        detailUseCase: DetailUseCase
    ) {
        self.detailUseCase = detailUseCase
    }
}

extension DetailViewModel {
    func requestGameDetail(id: Int) {
        self.shimmering.accept(true)
        detailUseCase.requestGameDetail(id: id).subscribe(onNext: { [unowned self] result in
            self.gameDetail.accept(result)
            self.requestFavorite()
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.pleaseCheckConnectionError)
            self.shimmering.accept(false)
        }).disposed(by: disposeBag)
    }
    
    func requestDeleteFavorite(id: Int) {
        detailUseCase.requestDeleteFavorite(id: id).subscribe(onNext: { [unowned self] result in
            self.isFavorite.accept(false)
            Logger.printLog("DELETE FAVORITE SUCCESS")
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.deleteFavoriteFailed)
        }).disposed(by: disposeBag)
    }
    
    func requestCreateFavorite(request: Game) {
        detailUseCase.requestCreateFavorite(request: request).subscribe(onNext: { [unowned self] result in
            self.isFavorite.accept(true)
            Logger.printLog("CREATE FAVORITE SUCCESS")
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.deleteFavoriteFailed)
        }).disposed(by: disposeBag)
    }
    
    func requestFavorite() {
        detailUseCase.requestFavoriteList().subscribe(onNext: { [unowned self] result in
            var isFavorite = false
            for favorite in result where favorite.id == gameDetail.value?.id {
                isFavorite = true
            }
            self.isFavorite.accept(isFavorite)
            Logger.printLog("RESULT requestFavorite ========== \(result)")
            self.shimmering.accept(false)
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.pleaseCheckConnectionError)
            self.shimmering.accept(false)
        }).disposed(by: disposeBag)
    }
}
