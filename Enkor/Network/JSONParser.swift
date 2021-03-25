//
//  JSONParser.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import Foundation
import SwiftyJSON

enum JSONParserError: Error {
    case keyNotExist
}

class JSONParser {
    let json: JSON
    init(json: JSON) {
        self.json = json
    }
    
    func _parse<T: Decodable>(key: String, type: T.Type) throws -> [T] {
        guard let areas = json[key].array else { throw JSONParserError.keyNotExist }
        let items = areas.compactMap {
            JSONModelConverter.decode(type: type, json: $0)
        }
        return items
    }
}
