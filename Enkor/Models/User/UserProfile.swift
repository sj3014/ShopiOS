//
//  UserProfile.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/18.
//

import Foundation

struct UserProfile : Codable {

        let authProvider : String?
        let countryID : String?
        let createdAt : String?
        let deletedAt : String?
        let email : String?
        let firstName : String?
        let kakao : String?
        let lastName : String?
        let phoneNumberKor : String?
        let phoneNumberNative : String?
        let profileIMG : String?
        let sex : String?
        let updatedAt : String?
        let userID : String?
        let uuid : String?

        enum CodingKeys: String, CodingKey {
                case authProvider = "authProvider"
                case countryID = "countryID"
                case createdAt = "createdAt"
                case deletedAt = "deletedAt"
                case email = "email"
                case firstName = "firstName"
                case kakao = "kakao"
                case lastName = "lastName"
                case phoneNumberKor = "phoneNumberKor"
                case phoneNumberNative = "phoneNumberNative"
                case profileIMG = "profileIMG"
                case sex = "sex"
                case updatedAt = "updatedAt"
                case userID = "userID"
                case uuid = "uuid"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                authProvider = try values.decodeIfPresent(String.self, forKey: .authProvider)
                countryID = try values.decodeIfPresent(String.self, forKey: .countryID)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                kakao = try values.decodeIfPresent(String.self, forKey: .kakao)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                phoneNumberKor = try values.decodeIfPresent(String.self, forKey: .phoneNumberKor)
                phoneNumberNative = try values.decodeIfPresent(String.self, forKey: .phoneNumberNative)
                profileIMG = try values.decodeIfPresent(String.self, forKey: .profileIMG)
                sex = try values.decodeIfPresent(String.self, forKey: .sex)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userID = try values.decodeIfPresent(String.self, forKey: .userID)
                uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        }

}
