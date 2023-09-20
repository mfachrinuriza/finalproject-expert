//
//  ProfileViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: NSObject {
    let loading: PublishSubject<Bool> = PublishSubject()
    let profile: PublishSubject<Profile> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    func requestProfileData() {
        loading.onNext(true)
        let data = Profile(
            email: "  mfachrinuriza@gmail.com  ",
            name: "Muhammad Fachri Nuriza",
            origin: "Palembang"
        )
        profile.onNext(data)
        loading.onNext(false)
    }
}
