//
//  WorkWithBasket.swift
//  GBShop
//
//  Created by Eduard on 30.01.2022.
//

import Foundation

class WorkWithBasket {
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Work with basket
    
    func addProductsBasket(productToAdd: AddProductToBasketRequest, completion: @escaping () -> Void){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.addProductsBasket(productToAdd:productToAdd) {response in
            switch response.result {
            case .success(let data):
                print("Товар добавлен в корзину успешно. Получен ответ: ", data, "\n")
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest, completion: @escaping () -> Void){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.deleteProductsBasket(productToDelete:productToDelete) {response in
            switch response.result {
            case .success(let data):
                print("Товар удален с корзины успешно. Получен ответ: ", data, "\n")
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func payBasket(amountFundsOnAccount: Int, costOfDelivery: Int, completion: @escaping (PayBasketResponse)-> Void){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.payBasket(amountFundsOnAccount:amountFundsOnAccount, costOfDelivery: costOfDelivery) {response in
            switch response.result {
            case .success(let data):
                print("Товар оплачен успешно. У Вас на счету осталось: ", data.amountFundsOnAccount, "\n")
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getBasket(completion: @escaping (GetBasketResponse) -> Void){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.getBasket() {response in
            switch response.result {
            case .success(let data):
                print("Запрос на получение корзины выполнен успешно. Получен ответ: ", data, "\n")
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
