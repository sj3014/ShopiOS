//
//  OrderDetail.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/26.
//

import Foundation

struct OrderDetail {
    let productID: Int
    let productOptionID: Int
    let productOptionName: String
    let productQuantity: Int
    let productOptionTotalPrice: Double
    let shippingFee: Double
    let totalPrice: Double
    let productImageURL: String
}
