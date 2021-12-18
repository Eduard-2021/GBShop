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
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    
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
    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (Data?) -> Void) {
        let requestModel = GetCatalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        
        AF.request(requestModel.fullUrl, method: requestModel.method, parameters: requestModel.parameters).responseData { [weak self] response in
            switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                    completionHandler(nil)
            }
        }
        
    }
    
    func getGoodById(idProduct: Int, completionHandler: @escaping (AFDataResponse<GetProductResult>) -> Void) {
        let requestModel = GetGoodByIdData(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
  
}


extension ProductData {
    struct GetCatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: Int
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "page_number" : pageNumber,
                "id_category" : idCategory,
            ]
        }
    }
    
    struct GetGoodByIdData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product" : idProduct,
            ]
        }
    }
    
}
