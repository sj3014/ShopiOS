//
//  UserAPIParser.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import UIKit

enum UserAPIParseError: Error {
    case noToken
    case noUser
}

class UserAPIParser: JSONParser {
    func parseToken() throws -> String {
        guard let token = json["token"].string else { throw UserAPIParseError.noToken }
        return token
    }
    
    func parseProfile() throws -> UserProfile {
        guard let profile = JSONModelConverter.decode(type: UserProfile.self, json: json["data"]["profile"]) else {
            print("ErrorWhileParsing")
            throw UserAPIParseError.noUser
        }
        return profile
    }
}
