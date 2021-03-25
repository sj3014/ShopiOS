//
//  ProductImage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation

struct ProductImage : Codable {

        let alt : String?
        let id : Int?
        let isBanner : Bool?
        let isMain : Bool?
        let isMobile : Bool?
        let key : String?
        let location : String?
        let order : Int?

        enum CodingKeys: String, CodingKey {
                case alt = "alt"
                case id = "id"
                case isBanner = "isBanner"
                case isMain = "isMain"
                case isMobile = "isMobile"
                case key = "key"
                case location = "location"
                case order = "order"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                alt = try values.decodeIfPresent(String.self, forKey: .alt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isBanner = try values.decodeIfPresent(Bool.self, forKey: .isBanner)
                isMain = try values.decodeIfPresent(Bool.self, forKey: .isMain)
                isMobile = try values.decodeIfPresent(Bool.self, forKey: .isMobile)
                key = try values.decodeIfPresent(String.self, forKey: .key)
                location = try values.decodeIfPresent(String.self, forKey: .location)
                order = try values.decodeIfPresent(Int.self, forKey: .order)
        }

}
