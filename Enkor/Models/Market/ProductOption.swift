//
//  ProductOption.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation

struct ProductOption : Codable {

        let createdAt : String?
        let currency : String?
        let deletedAt : String?
        let descriptionField : String?
        let discountPercentage : String?
        let id : Int?
        let isAvailable : Bool?
        let isSale : Bool?
        let name : String?
        let numAvailable : Int?
        let numSold : Int?
        let order : Int?
        let price : String?
        let priceFinal : Float?
        let productID : Int?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case currency = "currency"
                case deletedAt = "deletedAt"
                case descriptionField = "description"
                case discountPercentage = "discountPercentage"
                case id = "id"
                case isAvailable = "isAvailable"
                case isSale = "isSale"
                case name = "name"
                case numAvailable = "numAvailable"
                case numSold = "numSold"
                case order = "order"
                case price = "price"
                case priceFinal = "priceFinal"
                case productID = "productID"
                case updatedAt = "updatedAt"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                currency = try values.decodeIfPresent(String.self, forKey: .currency)
                deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                discountPercentage = try values.decodeIfPresent(String.self, forKey: .discountPercentage)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
                isSale = try values.decodeIfPresent(Bool.self, forKey: .isSale)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                numAvailable = try values.decodeIfPresent(Int.self, forKey: .numAvailable)
                numSold = try values.decodeIfPresent(Int.self, forKey: .numSold)
                order = try values.decodeIfPresent(Int.self, forKey: .order)
                price = try values.decodeIfPresent(String.self, forKey: .price)
                priceFinal = try values.decodeIfPresent(Float.self, forKey: .priceFinal)
                productID = try values.decodeIfPresent(Int.self, forKey: .productID)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
