//
//  ProductCategory.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation

struct ProductCategory : Codable {

        let createdAt : String?
        let id : Int?
        let isFresh : Bool?
        let name : String?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case id = "id"
                case isFresh = "isFresh"
                case name = "name"
                case updatedAt = "updatedAt"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isFresh = try values.decodeIfPresent(Bool.self, forKey: .isFresh)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
