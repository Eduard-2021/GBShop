//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
