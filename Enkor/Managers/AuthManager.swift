//
//  AuthManager.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation

import RxSwift
import SwiftyJSON

protocol AuthManagerProtocol {
//    var isSignedIn: Bool { get }
//    var isRegistered: Bool { get }
//    func parseTokenAndSave(json: JSON, user: User?) -> Observable<Void>
//    func clearUserAndTokenData()
//    func getToken() -> String?
}

class AuthManager: AuthManagerProtocol {
    enum AuthError: Error {
        case failedToSaveToken
        case failedToSaveUser
    }
    
    enum LoginState: Int {
        case logout = 0
        case login = 1
    }
    
    static let sharedInstance = AuthManager()
    private init() {
        didChangeLoginState
        .subscribe(onNext: { [weak self] state in
            self?.refreshUserID()
        })
        .disposed(by: disposeBag)
    }
    
    let secureTokenStorage = KeyChainTokenStorage()
    let userStorage = UserDefaultsProfileStorage()
    let didChangeLoginState = PublishSubject<LoginState>()
    let disposeBag = DisposeBag()
    
    var isSignedIn: Bool {
        guard let _ = userStorage.load() else {
            return false
        }
        guard let token = getToken() else { return false }
        return token.count > 0
    }
    
    var isRegistered: Bool {
        return userStorage.load() != nil
    }
    
    private var _userID: String? = nil
    var userID: String {
        get {
            if let userID = _userID {
                return userID
            } else {
                refreshUserID()
                return _userID!
            }
        }
    }
    
    private func refreshUserID() {
        //_userID = getSavedUser()?.id ?? "0"
    }
    
    func clearUserAndTokenData() {
        userStorage.remove()
        secureTokenStorage.remove()
        //NotificationCenter.default.post(name: .logout, object: nil)
        AuthManager.sharedInstance.didChangeLoginState.onNext(.logout)
    }
    
    func getToken() -> String? {
        return secureTokenStorage.load()
    }
    
    func parseUserProfile(json: JSON) -> Observable<Void> {
        return Observable<Void>.create { observer in
            do {
                let profile = try UserAPIParser(json: json).parseProfile()
                let error = self.save(profile: profile)
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
//    func parseTokenAndUserAndSaveForSignUp(json: JSON) -> Observable<Void> {
//        return Observable<Void>.create { observer in
//            do {
//                let token = try UserApiParser(json: json).parseToken()
//                let signUpUser = try UserApiParser(json: json).parseSignUpUser()
//                let user = User.from(signUpUser)
//                let error = self.save(token: token, user: user)
//                if let error = error {
//                    observer.onError(error)
//                } else {
//                    observer.onNext(())
//                    observer.onCompleted()
//                }
//            } catch {
//                observer.onError(error)
//            }
//            return Disposables.create()
//        }
//    }
//
//    func parseTokenAndUserAndSave(json: JSON) -> Observable<Void> {
//        return Observable<Void>.create { observer in
//            do {
//                let token = try UserAPIParser(json: json).parseToken()
//                let user = try UserAPIParser(json: json).parseUser()
//                let error = self.save(token: token, user: user)
//                if let error = error {
//                    observer.onError(error)
//                } else {
//                    observer.onNext(())
//                    observer.onCompleted()
//                }
//            } catch {
//                observer.onError(error)
//            }
//            return Disposables.create()
//        }
//    }
    
    func parseTokenAndSave(json: JSON) -> Observable<Void> {
        return Observable<Void>.create { observer in
            do {
                let token = try UserAPIParser(json: json).parseToken()
                let error = self.save(token: token)
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getSavedUserProfile() -> UserProfile? {
        return userStorage.load()
    }
    
//    private func update(user: User, json: JSON) -> User {
//        do {
//            let id = try UserApiParser(json: json).parseUserId()
//            var updated = user
//            updated.id = id
//            return updated
//        } catch {
//            return user
//        }
//    }
    
    private func save(token: String, userProfile: UserProfile) -> AuthError? {
        let tokenSaveError = save(token: token)
        if let error = tokenSaveError {
            return error
        }
        let profileSaveError = save(profile: userProfile)
        if let error = profileSaveError {
            return error
        }
        //NotificationCenter.default.post(name: .loggedIn, object: nil)
        return nil
    }
    
    private func save(token: String) -> AuthError? {
        let tokenSaved = secureTokenStorage.save(data: token)
        guard tokenSaved else {
            return .failedToSaveToken
        }
        return nil
    }
    
    private func save(profile: UserProfile) -> AuthError? {
        let uesrSaved = userStorage.save(data: profile)
        guard uesrSaved else {
            secureTokenStorage.remove()
            return .failedToSaveUser
        }
        return nil
    }
}

