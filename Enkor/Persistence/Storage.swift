//
//  Storage.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/16.
//

import Foundation

protocol Storage {
    associatedtype Item
    func save(data: Item) -> Bool
    func remove()
    func load() -> Item?
}
