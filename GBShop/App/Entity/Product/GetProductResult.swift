//
//  GetGoodByIdResult.swift
//  GBShop
//
//  Created by WorkUser2 on 09.12.2021.
//

import Foundation

struct GetProductResult: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}
