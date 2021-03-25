//
//  DeviceTokenStorage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/16.
//

import Foundation

class DeviceTokenStorage: Storage {
    typealias Item = String
    let key: String = "devicetoken"
    
    @discardableResult
    func save(data: String) -> Bool {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
        return true
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func load() -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
