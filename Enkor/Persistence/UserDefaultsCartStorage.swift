//
//  CartStorage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/25.
//

import Foundation

class UserDefaultsCartStorage: Storage {
    typealias Item = [Int]
    private let key = "currentCard"
    
    @discardableResult
    func save(data: [Int]) -> Bool {
        guard let encoded = try? JSONEncoder().encode(data) else {
            remove()
            return false
        }
        UserDefaults.standard.set(encoded, forKey: key)
        UserDefaults.standard.synchronize()
        return _load() != nil
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func load() -> [Int]? {
        guard let data = _load() else {
            return nil
        }
        return JSONModelConverter.decode(type: [Int].self, data: data)
    }
    
    private func _load() -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}
