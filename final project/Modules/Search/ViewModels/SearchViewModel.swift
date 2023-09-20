//
//  SearchViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewModel: BaseViewModel {
    let loading: PublishSubject<Bool> = PublishSubject()
    let filtered: PublishSubject<[Game]> = PublishSubject()
    
    var filteredData = [Game]()
    
    func getFilteredData(data: [Game], search: String?) {
        loading.onNext(true)
        if search == nil || search == "" {
            filtered.onNext(data)
        } else {
            filteredData = data.filter({ data -> Bool in
                return data.name!.range(of: search!, options: .caseInsensitive, range: nil, locale: nil) != nil
                
            })
            
            filtered.onNext(filteredData)
        }
        loading.onNext(false)
    }
}
