//
//  AddProductsBasketRequest.swift
//  GBShop
//
//  Created by Eduard on 19.12.2021.
//

import Foundation

struct AddProductToBasketRequest: Codable {
    let idProduct: Int
    var productsNumber: Int
}
