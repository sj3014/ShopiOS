//
//  LoginSessionViewModel.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import RxSwift
import RxCocoa

class LoginSessionViewModel: ErrorHandling {
    var errorMessage = PublishSubject<String>()
    var authError = PublishSubject<Void>()
    let loginFinished = PublishSubject<Void>()
    let fetchedUserProfile = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    let apiClient: UserAPI
    
    init(apiClient: UserAPI) {
        self.apiClient = apiClient
    }
    
    func login(email: String, password: String) {
        apiClient
            .login(email: email, password: password)
            .flatMap({ json in AuthManager.sharedInstance.parseTokenAndSave(json: json) })
            .subscribe(onNext: { [weak self] _ in
                print("SUCCESS")
                self?.loginFinished.onNext(())
            }, onError: { [weak self] error in
                print(error)
                self?.handleServerError(error)
            }).disposed(by: disposeBag)
    }
    
    func fetchProfile() {
        apiClient
            .getProfile()
            .flatMap({ json in AuthManager.sharedInstance.parseUserProfile(json: json)})
            .subscribe(onNext: { [weak self]  in
                self?.fetchedUserProfile.onNext(())
            }, onError: { [weak self] error in
                print(error)
                self?.handleServerError(error)
            }).disposed(by: disposeBag)
    }
}
