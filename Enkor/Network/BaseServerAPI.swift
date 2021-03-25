//
//  BaseServerAPI.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import Moya

class BaseServerAPI {
    static let defaultPlugins: [PluginType] = [BaseServerAPI.tokenPlugin]
    
    static let tokenPlugin = AccessTokenPlugin(tokenClosure: { _ in
        return AuthManager.sharedInstance.getToken() ?? ""
    })
}

class ServerErrorMessageParser {
    static func parse(error: Error) -> String {
        let defaultErrorMessage = "serverError"
        if let error = error as? MoyaError {
            do {
                if let body = try error.response?.mapJSON() as?
                    Dictionary<String, Any>, let msg = body["msg"] as?
                        String {
                    return msg
                }
            } catch {
                return defaultErrorMessage
            }
        }
        return defaultErrorMessage
    }
}
