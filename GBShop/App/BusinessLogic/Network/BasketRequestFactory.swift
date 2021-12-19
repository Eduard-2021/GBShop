//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Eduard on 19.12.2021.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    
    func addProductsBasket(productToAdd: AddProductToBasketRequest, completionHandler: @escaping (AFDataResponse<AddProductToBasketResponse>) -> Void)
    
    func deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest, completionHandler: @escaping (AFDataResponse<DeleteProductFromBasketResponse>) -> Void)
    
    func payBasket(amountFundsOnAccount: Int, completionHandler: @escaping (AFDataResponse<PayBasketResponse>) -> Void)
    
    func getBasket(completionHandler: @escaping (AFDataResponse<GetBasketResponse>) -> Void)
    
}
