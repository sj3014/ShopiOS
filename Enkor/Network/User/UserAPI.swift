//
//  UserAPI.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

class UserAPI: BaseServerAPI {
    var provider: MoyaProvider<UserService>
    
    init(provider: MoyaProvider<UserService>?) {
        if let provider = provider {
            self.provider = provider
        } else {
            self.provider = MoyaProvider<UserService>(plugins: BaseServerAPI.defaultPlugins)
        }
    }
    
    func signup(email: String, password: String) -> Observable<JSON> {
        return provider.rx
            .request(.signup(email: email, password: password))
            .asObservable()
            .map { response -> JSON in
                return JSON(response.data)
            }
    }
    
    func login(email: String, password: String) -> Observable<JSON> {
        return provider.rx
            .request(.login(email: email, password: password))
            .asObservable()
            .map { response -> JSON in
                return JSON(response.data)
            }
    }
    
    func getProfile() -> Observable<JSON> {
        return provider.rx
            .request(.getProfile)
            .asObservable()
            .map { response -> JSON in
                return JSON(response.data)
            }
    }
}
