//
//  MyPageViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/14.
//

import Foundation
import UIKit
import RxSwift

enum MyPageItems: String, CaseIterable {
    case login
    case logout
    case signup
    case order
    
    func title() -> String {
        return self.rawValue
    }
}

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    private var items = MyPageItems.allCases
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        tableView.register(MyPageTableViewCell.nib(), forCellReuseIdentifier: MyPageTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func bind() {
        AuthManager.sharedInstance
            .didChangeLoginState
            .subscribe(onNext: { [weak self] state in
                if state == .login {
                    if let userProfile = AuthManager.sharedInstance.getSavedUserProfile() {
                        self?.firstName.text = userProfile.firstName
                        self?.lastName.text = userProfile.lastName
                        self?.email.text = userProfile.email
                        
                    }
                } else {
                    self?.firstName.text = "Please Login"
                    self?.lastName.text = " "
                    self?.email.text = " "
                }
            })
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell") as! MyPageTableViewCell

        cell.title.text = items[indexPath.item].title()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = items[indexPath.item]

        switch item {
        case .login:
            proceedLogin()
        case .logout:
            guard AuthManager.sharedInstance.isSignedIn else { return }
            let alertController = UIAlertController(title: nil,
                                                    message: "Would you like to sign out of Enkor?",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "confirm",
                                                    style: .default) { _ in
                self.proceedLogout()
            })
            alertController.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        case .signup:
            proceedSignup()
        case .order:
            getOrder()
        }

    }

    private func proceedLogin() {
        let vc = Storyboard.Auth.create(withIdentifier: "LoginSession")
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }

    private func proceedLogout() {
        AuthManager.sharedInstance.clearUserAndTokenData()
    }

    private func proceedSignup() {

    }

    private func getOrder() {

    }
}

