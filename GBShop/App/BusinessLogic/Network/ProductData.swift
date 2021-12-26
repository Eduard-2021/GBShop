//
//  ProductData.swift
//  GBShop
//
//  Created by WorkUser2 on 09.12.2021.
//

import Foundation
import Alamofire

class ProductData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://secret-escarpment-71481.herokuapp.com/")!
    
    
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
        let requestModel = GetCatalogData(baseUrl: baseUrl, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }
    
    func getProductById(idProduct: Int, completionHandler: @escaping (AFDataResponse<OneProduct>) -> Void) {
        let requestModel = GetProductByIdData(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
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
                "idProduct" : idProduct,
            ]
        }
    }
    
}
