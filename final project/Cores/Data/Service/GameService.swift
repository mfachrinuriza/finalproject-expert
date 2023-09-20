//
//  GameService.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 30/09/22.
//

import RxSwift
import Alamofire

protocol GameServiceProtocol {
    func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>>
    func requestGameDetail(id: Int) -> Observable<GameData>
}

class GameService: BaseService {
    static let sharedInstance = GameService()
}

extension GameService: GameServiceProtocol {
    func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>> {
        return Observable.create { observer in
            let url = self.HOST_URL + API.getGames
            
            let queryParams = [
                "page_size": totalList,
                "key": self.API_KEY
            ] as [String : Any]
            
            AF.request(
                url,
                method: .get,
                parameters: queryParams,
                encoding: URLEncoding.default,
                headers: self.getHeaders()
            ).responseDecodable(of: BaseResponse<[GameData]>.self) { response in
                self.showResponseData(data: response.data)
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func requestGameDetail(id: Int) -> Observable<GameData> {
        return Observable.create { observer in
            var url = self.HOST_URL + API.getGames
            url.append("/\(id)")
            
            let queryParams = [
                "key": self.API_KEY
            ] as [String : Any]
            
            AF.request(
                url,
                method: .get,
                parameters: queryParams,
                encoding: URLEncoding.default,
                headers: self.getHeaders()
            ).responseDecodable(of: GameData.self) { response in
                self.showResponseData(data: response.data)
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

