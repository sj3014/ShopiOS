//
//  CartManager.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/25.
//

import Foundation

class CartManager {
    
    static let sharedInstance = CartManager()
    
    let cartStorage = UserDefaultsCartStorage()
    
    private init() {
        cartStorage.save(data: [])
    }
    
    func saveToCart(id: Int) {
        var optionIDs = cartStorage.load()
        optionIDs?.append(id)
        cartStorage.save(data: optionIDs ?? [])
    }
    
    func loadCart() -> [Int] {
        return cartStorage.load() ?? []
    }
    
}
