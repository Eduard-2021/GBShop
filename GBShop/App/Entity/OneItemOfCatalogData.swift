//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by WorkUser2 on 08.12.2021.
//

import Foundation

struct OneItemOfCatalogData {
    let idProduct: Int
    let productName: String
    let price: Int
    
    enum fieldName: String {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}
