//
//  ExtensionArray.swift
//  GBShop
//
//  Created by Eduard on 19.12.2021.
//

import Foundation


extension Array where Element: Encodable {
    func asArrayDictionary() throws -> [[String: Any]] {
        var data: [[String: Any]] = []

        for element in self {
            data.append(try element.asDictionary())
        }
        return data
    }
}

extension Encodable {
        func asDictionary() throws -> [String: Any] {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                throw NSError()
            }
            return dictionary
        }
}
