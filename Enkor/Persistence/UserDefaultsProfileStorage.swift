//
//  UserStorage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/16.
//

import Foundation

class UserDefaultsProfileStorage: Storage {
    
    typealias Item = UserProfile
    private let key = "currentUser"
    
    @discardableResult
    func save(data: UserProfile) -> Bool {
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
    
    func load() -> UserProfile? {
        guard let data = _load() else {
            return nil
        }
        return JSONModelConverter.decode(type: UserProfile.self, data: data)
    }
    
    private func _load() -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}
