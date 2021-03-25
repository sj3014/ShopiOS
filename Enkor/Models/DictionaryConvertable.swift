//
//  DictionaryConvertable.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/17.
//

import UIKit

protocol DictionaryConvertable {

}

extension DictionaryConvertable where Self: Codable {
    func toDict() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func toDict(excludeKeys: [String]) -> [String: Any]? {
        guard var dict = toDict() else {
            return nil
        }
        for (k, _) in dict {
            for k2 in excludeKeys {
                if k == k2 {
                    dict.removeValue(forKey: k2)
                }
            }
        }
        return dict
    }
}

