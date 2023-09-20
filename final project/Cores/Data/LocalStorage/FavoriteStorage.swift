//
//  FavoriteStorage.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import CoreData
import RxSwift
import RxCocoa

protocol FavoriteStorageProtocol {
    func requestFavoriteList() -> Observable<[GameData]>
    func requestFavoriteDetail(id: Int) -> Observable<GameData>
    func requestCreateFavorite(request: GameData) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

class FavoriteStorage: NSObject {
    static let sharedInstance = FavoriteStorage()
}

extension FavoriteStorage: FavoriteStorageProtocol {
    func requestFavoriteList() -> Observable<[GameData]> {
        return Observable.create { observer in
            var favoriteList = [GameData]()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            
            do {
                let result = try manageContext.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    favoriteList.append(
                        GameData(
                            id: data.value(forKey: "id") as? Int,
                            slug: data.value(forKey: "slug") as? String,
                            name: data.value(forKey: "name") as? String,
                            released: data.value(forKey: "released") as? String,
                            description: data.value(forKey: "description_game") as? String,
                            background_image: data.value(forKey: "background_image") as? String,
                            rating: data.value(forKey: "rating") as? Double
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(favoriteList)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func requestFavoriteDetail(id: Int) -> Observable<GameData> {
        return Observable.create { observer in
            var favoriteDetail = [GameData]()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                let result = try manageContext.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    favoriteDetail.append(
                        GameData(
                            id: data.value(forKey: "id") as? Int,
                            slug: data.value(forKey: "slug") as? String,
                            name: data.value(forKey: "name") as? String,
                            released: data.value(forKey: "released") as? String,
                            description: data.value(forKey: "description_game") as? String,
                            background_image: data.value(forKey: "background_image") as? String,
                            rating: data.value(forKey: "rating") as? Double
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(favoriteDetail[0])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func requestCreateFavorite(request: GameData) -> Observable<String> {
        return Observable.create { observer in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: manageContext)
            
            let insert = NSManagedObject(entity: entity!, insertInto: manageContext)
            insert.setValue(request.id, forKey: "id")
            insert.setValue(request.slug, forKey: "slug")
            insert.setValue(request.name, forKey: "name")
            insert.setValue(request.released, forKey: "released")
            insert.setValue(request.description, forKey: "description_game")
            insert.setValue(request.background_image, forKey: "background_image")
            insert.setValue(request.rating, forKey: "rating")
            
            do{
                try manageContext.save()
                observer.onNext(ServiceSuccess.createFavoriteSuccess)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func requestDeleteFavorite(id: Int) -> Observable<String> {
        return Observable.create { observer in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            do {
                let fetch = try manageContext.fetch(fetchRequest)
                let delete = fetch[0] as! NSManagedObject
                manageContext.delete(delete)
                try manageContext.save()
                
                observer.onNext(ServiceSuccess.deleteFavoriteSuccess)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
