//
//  ProductAPIParser.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit

enum ProductAPIParseError: Error {
    case noProduct
}

class ProductAPIParser: JSONParser {
    func parseProductList() throws -> [Product] {
        guard let productList = JSONModelConverter.decode(type: [Product].self, json: json["data"]["products"]) else {
            throw ProductAPIParseError.noProduct
        }
        
        return productList
    }
    
    func parseProductDetail() throws -> Product {
        guard let productDetail = JSONModelConverter.decode(type: Product.self, json: json["data"]["product"]) else {
            throw ProductAPIParseError.noProduct
        }
        
        return productDetail
    }
}
