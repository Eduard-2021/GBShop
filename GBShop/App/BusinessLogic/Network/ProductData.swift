//
//  ProductData.swift
//  GBShop
//
//  Created by WorkUser2 on 09.12.2021.
//

import Foundation
import Alamofire
import UIKit

class ProductData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
//    let baseUrl = URL(string: "http://secret-escarpment-71481.herokuapp.com/")!
    
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ProductData: ProductRequestFactory {
    
    func getCatalogData(idCategory: Int, completionHandler: @escaping (AFDataResponse<ProductCatalog>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetCatalogData(baseUrl: baseUrl, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }
    
    func getProductById(idProduct: Int, completionHandler: @escaping (AFDataResponse<OneProduct>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetProductByIdData(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductByCategory(idCategory: Int, completionHandler: @escaping (AFDataResponse<AllProductsSomeCategoryResponse>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetProductByCatogoryData(baseUrl: baseUrl, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductByPromotion(promotion: Int, completionHandler: @escaping (AFDataResponse<AllProductsWithPromotionResponse>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetProductByPromotionData(baseUrl: baseUrl, promotion: promotion)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func uploadProductToServer(oneProduct: OneProduct, completionHandler: @escaping (AFDataResponse<UploadProductToServerResponse>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = UploadProductToServerRequest(baseUrl: baseUrl)
        self.upload(
            multipartFormData:{ multipartFormData in
                guard let idProduct = oneProduct.idProduct.description.data(using: .utf8),
                      let productPrice = oneProduct.productPrice.description.data(using: .utf8),
                      let idCategory = oneProduct.idCategory.description.data(using: .utf8),
                      let promotion = oneProduct.promotion.description.data(using: .utf8)
                else {return}
                 
                multipartFormData.append(idProduct, withName: "idProduct")
                multipartFormData.append(oneProduct.productName.data(using: .utf8, allowLossyConversion: false)!, withName: "productName")
                multipartFormData.append(productPrice, withName: "productPrice")
                multipartFormData.append(oneProduct.productDescription.data(using: .utf8, allowLossyConversion: false)!, withName: "productDescription")
                multipartFormData.append(idCategory, withName: "idCategory")
                multipartFormData.append(promotion, withName: "promotion")
                multipartFormData.append(oneProduct.productImage, withName: requestModel.key)
            },
            to: requestModel,
            completionHandler: completionHandler)
    }
}


extension ProductData {
    struct GetCatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getCatalogData"
        
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "idCategory" : idCategory,
            ]
        }
    }
    
    struct GetProductByIdData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductById"
        
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "idProduct" : [idProduct],
            ]
        }
    }
    
    struct UploadProductToServerRequest: URLConvertible {
        let baseUrl: URL
        let path: String = "uploadProductToServer"
        func asURL() throws -> URL {
            return baseUrl.appendingPathComponent(path)
        }
        let key = "productImage"
    }
    
    
    
    struct GetProductByCatogoryData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductByCategory"
        
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "idCategory" : idCategory
            ]
        }
    }
    
    struct GetProductByPromotionData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductByPromotion"
        
        let promotion: Int
        var parameters: Parameters? {
            return [
                "promotion" : promotion
            ]
        }
    }
}


