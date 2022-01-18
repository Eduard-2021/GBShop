//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by WorkUser2 on 08.12.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getCatalogData(idCategory: Int, completionHandler: @escaping (AFDataResponse<ProductCatalog>) -> Void)
    
    func getProductById(idProduct: Int, completionHandler: @escaping (AFDataResponse<OneProduct>) -> Void)
    
    func getProductByCategory(idCategory: Int, completionHandler: @escaping (AFDataResponse<AllProductsSomeCategoryResponse>) -> Void)
    
    func getProductByPromotion(promotion: Int, completionHandler: @escaping (AFDataResponse<AllProductsWithPromotionResponse>) -> Void)
    
    func uploadProductToServer(oneProduct: OneProduct, completionHandler: @escaping (AFDataResponse<UploadProductToServerResponse>) -> Void)
}

