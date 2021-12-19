//
//  DeleteProductsBasketRequest.swift
//  
//
//  Created by Eduard on 18.12.2021.
//

import Foundation

struct DeleteProductFromBasketRequest: Codable {
    let idProduct: Int
    var productsNumber: Int
}
