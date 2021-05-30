//
//  LoginSessionViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import UIKit
import RxSwift

class LoginSessionViewController: ReactiveViewController, ErrorDisplayable {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    var errorMessage: Observable<String>? {
        return viewModel.errorMessage.asObservable()
    }
    
    var authError: Observable<Void>? {
        return viewModel.authError.asObservable()
    }
    let viewModel = LoginSessionViewModel(apiClient: UserAPI(provider:nil))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

        // Do any additional setup after loading the view.
    }
    
    func bind() {
        bindErrorMessageDisplay()
        bindAuthError()
        viewModel
            .loginFinished
            .subscribe(onNext: {
                self.viewModel.fetchProfile()
                AuthManager.sharedInstance.didChangeLoginState.onNext(.login)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        viewModel
            .fetchedUserProfile
            .subscribe(onNext: {
                AuthManager.sharedInstance.didChangeLoginState.onNext(.login)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        guard let emailEntry = email.text, let passwordEntry = password.text else { return }
//        guard emailEntry.count > 0 else {
//            UIAlertController.displayAlert(title: nil, message: "validation_email".localized(), presenter: self)
//            return
//        }
//
//        guard passwordEntry.count > 0 else {
//            UIAlertController.displayAlert(title: nil, message: "validation_password".localized(), presenter: self)
//            return
//        }
        viewModel.login(email: emailEntry, password: passwordEntry)
    }
    
}

