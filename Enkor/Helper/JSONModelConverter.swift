//
//  JSONModelConverter.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import SwiftyJSON

class JSONModelConverter {
    static func decode<T: Decodable>(type: T.Type, json: JSON) -> T? {
        guard let rawData = try? json.rawData() else { return nil }
        return decode(type: type, data: rawData)
    }
    
    static func decode<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(T.self, from: data)
        return decoded
    }
}
