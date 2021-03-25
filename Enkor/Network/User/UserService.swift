//
//  UserService.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import Moya

enum UserService {
    case login(email: String, password: String)
    case signup(email: String, password: String)
    case getProfile
}

extension UserService: TargetType, AccessTokenAuthorizable {
    var path: String {
        switch self {
        case .login:
            return "/auth/c/loginTest"
        case .signup:
            return "/auth/c/register"
        case .getProfile:
            return "/usr/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password), .signup(let email, let password):
            var body = [String:Any]()
            body["email"] = email
            body["password"] = password
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        case .getProfile:
            return .requestPlain
        }
    }
    
    var headers: [String:String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .signup:
            return .none
        default:
            return .bearer
        }
    }
    
    var baseURL: URL {
        let baseURL = "\(AppConfigure.shared.baseURL)/api"
        guard let url = URL(string: baseURL) else { fatalError("baseURL could not be configured")}
        return url
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
