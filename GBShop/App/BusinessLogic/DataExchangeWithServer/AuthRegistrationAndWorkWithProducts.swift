//
//  AuthAndRegistration.swift
//  GBShop
//
//  Created by Eduard on 27.12.2021.
//

import UIKit

class AuthRegistrationAndWorkWithProducts {
    
    var loginAndRegisterViewControllerDelegate: AuthAndRegisterProtocol!
    
    private let requestFactory = RequestFactory()
    
    func login(phoneNumber: String, password: String, complition: @escaping (Bool) -> Void){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(phoneNumber: phoneNumber, password: password) { response in
            switch response.result {
            case .success(let login):
                if login.result == 0 {
                    DispatchQueue.main.async {
                        self.loginAndRegisterViewControllerDelegate.unCorrectLoginPaswordOrEmptyField()
                    }
                    complition(false)
                }
                else {
                    Constant.shared.user = login.user
                    complition(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String, complition: @escaping (Bool) -> Void){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(email: email, password: password) { response in
            switch response.result {
            case .success(let login):
                if login.result == 0 {
                    DispatchQueue.main.async {
                        self.loginAndRegisterViewControllerDelegate.unCorrectLoginPaswordOrEmptyField()
                    }
                    complition(false)
                }
                else {
                    Constant.shared.user = login.user
                    complition(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout(idUser: Int, complition: @escaping (Bool) -> Void){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(idUser: idUser) { response in
            switch response.result {
            case .success:
                Constant.shared.user = nil
                complition(true)
            case .failure(let error):
                complition(false)
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Register and change data
    
    func register(newUser: NewUser, complition: @escaping (Bool) -> Void){
        let userData = requestFactory.makeUserDataRequestFactory()
        userData.register(newUser: newUser) { response in
            switch response.result {
            case .success(let data):
                if data.result == 0 {
                    DispatchQueue.main.async {
                        self.loginAndRegisterViewControllerDelegate.unCorrectLoginPaswordOrEmptyField()
                    }
                    complition(false)
                }
                else {
                    complition(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    
    func changeData(newUser: NewUser, complition: @escaping (Bool) -> Void){
        let userData = requestFactory.makeUserDataRequestFactory()
        userData.changeData(newUser: newUser) {response in
            switch response.result {
            case .success(let data):
                if data.result == 0 {
                    DispatchQueue.main.async {
                        self.loginAndRegisterViewControllerDelegate.unCorrectLoginPaswordOrEmptyField()
                    }
                    complition(false)
                }
                else {
                    complition(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func numberOfUsers(complition: @escaping (Int) -> Void) {
        let userData = requestFactory.makeUserDataRequestFactory()
        userData.numberOfUsers {response in
            switch response.result {
            case .success(let data):
                complition(data.result)
                print("Запрос на получение пользователей выполнен успешно. Полученен ответ: ", data.result, "\n")
            case .failure(let error):
                print(error.localizedDescription)
                complition(0)
            }
        }
    }
    
    // MARK: - Upload and Download Products
    
    func upLoadProducts(products: [OneProduct], complition: @escaping (Int) -> Void) {
        let product = requestFactory.makeProductRequestFactory()
        
        var uploadProductsNumber = 0
        
        for oneProduct in products {
            product.uploadProductToServer(oneProduct: oneProduct) {response in
                switch response.result {
                case .success(let data):
                    uploadProductsNumber += 1
                    if uploadProductsNumber == products.count {
                        complition(data.result)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    uploadProductsNumber += 1
                    if uploadProductsNumber == products.count {
                        complition(0)
                    }
                }
            }
        }
    }
    
    func getProductByCategory(idCategory: Int, complition: @escaping ([OneProduct]) -> Void) {
        let getProducts = requestFactory.makeProductRequestFactory()
        getProducts.getProductByCategory(idCategory: idCategory) {response in
                switch response.result {
                case .success(let data):
                    complition(data.result)
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([OneProduct]())
                }
            }

    }
    
    
    func getProductByPromotion(promotion: Int, complition: @escaping ([OneProduct]) -> Void) {
        let getProducts = requestFactory.makeProductRequestFactory()
        getProducts.getProductByPromotion(promotion: promotion) {response in
                switch response.result {
                case .success(let data):
                    complition(data.result)
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([OneProduct]())
                }
            }

    }
    
    //MARK: Work wirh comments
    
    func createNewComment(newComment: NewComment, completion: @escaping (Bool)-> Void){
        let comments = requestFactory.makeCommentRequestFactory()
        comments.createNewComment(newComment: newComment) {response in
            switch response.result {
            case .success(let data):
                print("Новый комментарий внесен успешно. Полученен ответ: ", data, "\n")
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func uploadAllCommentsOfProduct(allCommentsOfProduct: UploadAllCommentsOfProductRequest, completion: @escaping (Bool)-> Void){
        let comments = requestFactory.makeCommentRequestFactory()
        comments.uploadAllCommentsOfProduct(allCommentsOfProduct: allCommentsOfProduct) {response in
            switch response.result {
            case .success(let data):
                print("Новый комментарии внесены успешно. Полученен ответ: ", data, "\n")
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    
    //MARK: - Category
    func uploadCategory(categories: [Category], completion: @escaping (Bool)-> Void){
        let categoryFactory = requestFactory.makeCategoryRequestFactory()
        
        var uploadCategotiesNumber = 0
        
        for category in categories {
            categoryFactory.uploadCategoryToServer(category: category) {response in
                uploadCategotiesNumber += 1
                switch response.result {
                case .success(let data):
                    if uploadCategotiesNumber == categories.count {
                        print("Новый категории выгружены успешно. Полученен ответ: ", data, "\n")
                        completion(true)
                    }
                case .failure(let error):
                    uploadCategotiesNumber += 1
                    print(error.localizedDescription)
                    if uploadCategotiesNumber == categories.count {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func getAllCategories(complition: @escaping ([Category]) -> Void) {
        let categoryFactory = requestFactory.makeCategoryRequestFactory()
        categoryFactory.getAllCategories {response in
                switch response.result {
                case .success(let data):
                    complition(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([Category]())
                }
            }

    }
    
}
