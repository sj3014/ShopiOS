//
//  UIAlertController+.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/18.
//

import UIKit

extension UIAlertController {
    static func displayAlert(title: String?, message: String?, handler: ((UIAlertAction)->())? = nil, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "confirm", style: .default, handler: handler))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func displayAlertWithCancel(title: String?, message: String?, handler: ((UIAlertAction)->())? = nil, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "confirm", style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
}
