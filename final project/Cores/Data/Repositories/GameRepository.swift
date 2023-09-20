//
//  GameRepository.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 30/09/22.
//

import RxSwift

protocol GameRepositoryProtocol {
    func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>>
    func requestGameDetail(id: Int) -> Observable<GameData>
}

class GameRepository: NSObject {
        
    let service: GameServiceProtocol
    
    static let sharedInstance = {
        let service = GameService.sharedInstance
        return GameRepository(service: service)
    }()
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
}

extension GameRepository: GameRepositoryProtocol {
    func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>> {
        return service.requestGameList(totalList: totalList)
    }
    
    func requestGameDetail(id: Int) -> Observable<GameData> {
        return service.requestGameDetail(id: id)
    }
}

