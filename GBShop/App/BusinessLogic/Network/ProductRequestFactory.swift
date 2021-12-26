//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by WorkUser2 on 08.12.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (Data?) -> Void)
    
    func getGoodById(idProduct: Int, completionHandler: @escaping (AFDataResponse<GetProductResult>) -> Void)
}

