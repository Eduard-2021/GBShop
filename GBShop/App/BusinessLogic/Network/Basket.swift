//
//  Basket.swift
//  GBShop
//
//  Created by Eduard on 19.12.2021.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
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

extension Basket: BasketRequestFactory {
    
    func addProductsBasket(productToAdd: AddProductToBasketRequest, completionHandler: @escaping (AFDataResponse<AddProductToBasketResponse>) -> Void) {
        
//        let convertProductToAdd = try! productsToAdd.productsToAdd.asArrayDictionary()
        let requestModel = AddProductsBasket(baseUrl: baseUrl, productToAdd: productToAdd)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest, completionHandler: @escaping (AFDataResponse<DeleteProductFromBasketResponse>) -> Void) {
        let requestModel = DeleteProductsBasket(baseUrl: baseUrl, productToDelete: productToDelete)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payBasket(amountFundsOnAccount: Int, completionHandler: @escaping (AFDataResponse<PayBasketResponse>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl, amountFundsOnAccount: amountFundsOnAccount)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBasket(completionHandler: @escaping (AFDataResponse<GetBasketResponse>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct AddProductsBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addProductsBasket"
        
        var productToAdd: AddProductToBasketRequest
        var parameters: Parameters? {
            return [
                "idProduct": productToAdd.idProduct,
                "productsNumber": productToAdd.productsNumber
            ]
        }
    }
    
    struct DeleteProductsBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteProductsBasket"
        
        var productToDelete: DeleteProductFromBasketRequest
        var parameters: Parameters? {
            return [
                "idProduct": productToDelete.idProduct,
                "productsNumber": productToDelete.productsNumber
            ]
        }
    }
    
    struct PayBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        
        var amountFundsOnAccount: Int
        var parameters: Parameters? {
            return [
                "amountFundsOnAccount": amountFundsOnAccount
            ]
        }
    }
    
    struct GetBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"
        
        var parameters: Parameters? {
            return [:]
        }
    }
    
}
