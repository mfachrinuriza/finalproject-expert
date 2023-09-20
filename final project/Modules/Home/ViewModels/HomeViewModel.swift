//
//  HomeViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit
import RxCocoa
import RxSwift

enum APIEnum {
    case list
    case popular
}

class HomeViewModel: BaseViewModel {
    let error: PublishRelay<String> = PublishRelay()
    let loading: PublishRelay<Bool> = PublishRelay()
    
    let gameList: BehaviorRelay<[Game]> = BehaviorRelay(value: [])
    let gamePupular: BehaviorRelay<[Game]> = BehaviorRelay(value: [])
    let selectedGameId: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    
    var homeUseCase: HomeUseCase
    
    init(
        homeUseCase: HomeUseCase
    ) {
        self.homeUseCase = homeUseCase
    }
}

extension HomeViewModel {
    func requestGamePopular() {
        self.loading.accept(true)
        homeUseCase.requestGameList(totalList: 5).subscribe(onNext: { [unowned self] results in
            gamePupular.accept(results)
            self.requestGameList()
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.pleaseCheckConnectionError)
            self.loading.accept(false)
        }).disposed(by: disposeBag)
    }
    
    func requestGameList() {
        homeUseCase.requestGameList(totalList: 15).subscribe(onNext: { [unowned self] results in
            self.gameList.accept(results)
            self.loading.accept(false)
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.pleaseCheckConnectionError)
            self.loading.accept(false)
        }).disposed(by: disposeBag)
    }
}
