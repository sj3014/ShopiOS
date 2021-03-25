//
//  Product.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation

struct Product : Codable {
    
    let availableFrom : String?
    let brandID : String?
    let createdAt : String?
    let dateRequired : Bool?
    let deletedAt : String?
    let deliveryFee : String?
    let deliveryType : String?
    let displayPromoBanner : Bool?
    let id : Int?
    let isAvailable : Bool?
    let live : Bool?
    let name : String?
    let order : Int?
    let productCategory : ProductCategory?
    let productCategoryID : Int?
    let productCode : String?
    let productImages : [ProductImage]?
    let productOptions : [ProductOption]?
    let promoBannerText : String?
    let purchaseQuantityMax : Int?
    let purchaseQuantityMin : Int?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case availableFrom = "availableFrom"
        case brandID = "brandID"
        case createdAt = "createdAt"
        case dateRequired = "dateRequired"
        case deletedAt = "deletedAt"
        case deliveryFee = "deliveryFee"
        case deliveryType = "deliveryType"
        case displayPromoBanner = "displayPromoBanner"
        case id = "id"
        case isAvailable = "isAvailable"
        case live = "live"
        case name = "name"
        case order = "order"
        case productCategory = "ProductCategory"
        case productCategoryID = "productCategoryID"
        case productCode = "productCode"
        case productImages = "ProductImages"
        case productOptions = "ProductOptions"
        case promoBannerText = "promoBannerText"
        case purchaseQuantityMax = "purchaseQuantityMax"
        case purchaseQuantityMin = "purchaseQuantityMin"
        case updatedAt = "updatedAt"
    }
    
    static func empty() -> Product {
        return Product(availableFrom: "", brandID: "", createdAt: "", dateRequired: false, deletedAt: "", deliveryFee: "", deliveryType: "", displayPromoBanner: false, id: 0, isAvailable: false, live: false, name: "", order: 0, productCategory: nil, productCategoryID: 0, productCode: "", productImages: [], productOptions: [], promoBannerText: "", purchaseQuantityMax: 0, purchaseQuantityMin: 0, updatedAt: "")
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        availableFrom = try values.decodeIfPresent(String.self, forKey: .availableFrom)
//        brandID = try values.decodeIfPresent(String.self, forKey: .brandID)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        dateRequired = try values.decodeIfPresent(Bool.self, forKey: .dateRequired)
//        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
//        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
//        deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
//        displayPromoBanner = try values.decodeIfPresent(Bool.self, forKey: .displayPromoBanner)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
//        live = try values.decodeIfPresent(Bool.self, forKey: .live)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        order = try values.decodeIfPresent(Int.self, forKey: .order)
//        productCategory = try values.decodeIfPresent(ProductCategory.self, forKey: .productCategory)
//        productCategoryID = try values.decodeIfPresent(Int.self, forKey: .productCategoryID)
//        productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
//        productImages = try values.decodeIfPresent([ProductImage].self, forKey: .productImages)
//        productOptions = try values.decodeIfPresent([ProductOption].self, forKey: .productOptions)
//        promoBannerText = try values.decodeIfPresent(String.self, forKey: .promoBannerText)
//        purchaseQuantityMax = try values.decodeIfPresent(Int.self, forKey: .purchaseQuantityMax)
//        purchaseQuantityMin = try values.decodeIfPresent(Int.self, forKey: .purchaseQuantityMin)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//    }
    
    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        availableFrom = try values.decodeIfPresent(String.self, forKey: .availableFrom)
//        brandID = try values.decodeIfPresent(String.self, forKey: .brandID)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        dateRequired = try values.decodeIfPresent(Bool.self, forKey: .dateRequired)
//        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
//        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
//        deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
//        displayPromoBanner = try values.decodeIfPresent(Bool.self, forKey: .displayPromoBanner)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
//        live = try values.decodeIfPresent(Bool.self, forKey: .live)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        order = try values.decodeIfPresent(Int.self, forKey: .order)
//        productCategory = try values.decodeIfPresent(ProductCategory.self, forKey: .productCategory)
//        productCategoryID = try values.decodeIfPresent(Int.self, forKey: .productCategoryID)
//        productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
//        productImages = try values.decodeIfPresent([ProductImage].self, forKey: .productImages)
//        productOptions = try values.decodeIfPresent([ProductOption].self, forKey: .productOptions)
//        promoBannerText = try values.decodeIfPresent(String.self, forKey: .promoBannerText)
//        purchaseQuantityMax = try values.decodeIfPresent(Int.self, forKey: .purchaseQuantityMax)
//        purchaseQuantityMin = try values.decodeIfPresent(Int.self, forKey: .purchaseQuantityMin)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//    }
    
}

func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.name == rhs.name && lhs.productOptions?[0].price == rhs.productOptions?[0].price && lhs.promoBannerText == rhs.promoBannerText && lhs.productImages?[0].location == rhs.productImages?[0].location
}
