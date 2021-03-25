//
//  ErrorDisplayable.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/18.
//

import Foundation
import RxSwift

protocol ErrorDisplayable {
    var errorMessage: Observable<String>? { get }
    var authError: Observable<Void>? { get }
    //var resetError: Observable<Void>? { get }
}

extension ErrorDisplayable where Self: ReactiveViewController {
    func bindErrorMessageDisplay() {
        errorMessage?
            .subscribe(onNext: { [weak self] msg in
                guard let self = self else { return }
                UIAlertController.displayAlert(title: nil, message: msg, presenter: self)
            })
            .disposed(by: disposeBag)
    }
    
    func bindAuthError() {
        authError?
            .subscribe(onNext: { [weak self] in
                _ = self?.presentSignUpAlertIfNeeded()
                self?.presentVerifyAlert()
//                AuthManager.sharedInstance.clearUserAndTokenData()
            })
            .disposed(by: disposeBag)
    }
    
//    func bindResetError() {
//        resetError?
//            .subscribe(onNext: { [weak self] in
//                self?.presentResetAlert()
//            })
//            .disposed(by: disposeBag)
//    }
}

