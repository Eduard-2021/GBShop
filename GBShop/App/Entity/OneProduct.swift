//
//  OneProduct.swift
//  GBShop
//
//  Created by WorkUser2 on 16.12.2021.
//

import Foundation

struct OneProduct: Codable {
    let idProduct: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    var commentList: [OneComment]

}
