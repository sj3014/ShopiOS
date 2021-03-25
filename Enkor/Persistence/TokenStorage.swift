//
//  TokenStorage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/17.
//

import Foundation
import SwiftKeychainWrapper

class KeyChainTokenStorage: Storage {
    typealias Item = String
    let keychainKey: String = "auth.jwt"
    func save(data: String) -> Bool {
        return KeychainWrapper.standard.set(data, forKey: keychainKey)
    }
    
    func remove() {
        KeychainWrapper.standard.removeObject(forKey: keychainKey)
    }
    
    func load() -> String? {
        return KeychainWrapper.standard.string(forKey: keychainKey)
    }
}
