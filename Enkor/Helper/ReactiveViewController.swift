//
//  ReactiveViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/18.
//

import UIKit
import RxSwift

class ReactiveViewController: UIViewController {
    var disposeBag = DisposeBag()
}

extension UIViewController {
    func presentSignUpAlertIfNeeded() -> Bool {
        return UIViewController.presentSignUpAlertIfNeeded(on: self)
    }
    
    static func presentSignUpAlertIfNeeded(on: UIViewController) -> Bool {
        guard !AuthManager.sharedInstance.isSignedIn else { return false }
        let alertController = UIAlertController(title: nil,
                                                message: "alert_needs_signup_description",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
//        alertController.addAction(UIAlertAction(title: "alert_needs_signup_confirm",
//                                                style: .default) { _ in
//            if let vc = Storyboard.LoginMenu.create() as? LoginMenuViewController {
//                vc.modalPresentationStyle = .fullScreen
//                on.present(vc, animated: true, completion: nil)
//            }
//        })
//        on.present(alertController, animated: true, completion: nil)
        return true
    }
    
    func presentVerifyAlert() -> Void {
        return UIViewController.presentVerifyAlert(on: self)
    }
    
    static func presentVerifyAlert(on: UIViewController) -> Void {
        let alertController = UIAlertController(title: nil,
                                                message: "verify_email_noti",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "confirm", style: .cancel, handler: nil))
        on.present(alertController, animated: true, completion: nil)
    }
    
    func presentResetAlert() -> Void {
        return UIViewController.presentResetAlert(on: self)
    }
    
    static func presentResetAlert(on: UIViewController) -> Void {
        let alertController = UIAlertController(title: nil,
                                                message: "alert_needs_reset_password",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "confirm", style: .cancel, handler: nil))
        on.present(alertController, animated: true, completion: nil)
    }
}
