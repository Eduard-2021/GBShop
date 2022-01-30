//
//  HomeworkCallFromOneToSix.swift
//  GBShop
//
//  Created by Eduard on 27.12.2021.
//

import UIKit

class HomeworkCallFromOneToSix {
    
    private let requestFactory = RequestFactory()
    
    func callAll() {
        logging(.funcStart)
        workWithData()
        logging(self)
        logging(.funcEnd)
    }
    
    // MARK: - Call all func
    
    private func workWithData(){
        let newUser = createNewUser()
        login(phoneNumber: "+380121212121", password: "mypassword")
        login(email: "email@email", password: "mypassword")
//        logout(idUser: 123)
//        register(newUser: newUser)
//        changeData(newUser: newUser)
//        getCatalogData(idCategory: 1)
//        getOneProduct(idProduct: 123)
//        setGetDeleteComments()
//        addDeletePayGetBasket()
    }
    
    private func createNewUser() -> NewUser {
        return NewUser(
                     idUser: 123,
                     userName: "Somebody",
                     password: "mypassword",
                     email: "some@some.ru",
                     phoneNumber: "",
                     gender: "m",
                     creditCard: "9872389-2424-234224-234",
                     bio: "This is good! I think I will switch to another language"
               )
               
    }
    
    private func setGetDeleteComments(){
        
        let newComment = NewComment(
            idProduct: 123,
            commentatorName: "Сергей",
            commentDate: "19.12.21",
            comment: "Надежное изделие",
            score: 5.0,
            liked: "Понравилось быстродействие",
            noLiked: "",
            userExperienсe:"Один день")

        getCommentList(idProduct: 123) {_ in}
        setNewComment(newComment: newComment) {isSuccess in
            if isSuccess {
                print("Товар уже с новым комментарием:")
                self.getCommentList(idProduct: 123) {oneProduct in
                    guard let oneProduct = oneProduct
//                            ,let lastComment = oneProduct.commentList.last
                    else {return}
//                        self.deleteComment(idProduct: 123, idComment: lastComment.idComment)
                }
            }
        }
    }
    
    private func addDeletePayGetBasket() {
        getBasket(){
            self.addProductsBasket(productToAdd: AddProductToBasketRequest(idProduct: 123, productsNumber: 3)){
                self.getBasket() {
                    self.deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest(idProduct: 123, productsNumber: 1)) {
                            self.getBasket() {
                                self.payBasket(amountFundsOnAccount: 200000) //amountFundsOnAccount - это условное количество денег на счету у клиента
                            }
                    }
                }
            }
        }
    }
    

    // MARK: - AUTH
    
    private func login(phoneNumber: String, password: String){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(phoneNumber: phoneNumber, password: password) { response in
            switch response.result {
            case .success(let login):
                print("Аунтефикация прошла успешно. Полученен ответ: ", login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func login(email: String, password: String){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(email: email, password: password) { response in
            switch response.result {
            case .success(let login):
                print("Аунтефикация прошла успешно. Полученен ответ: ", login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func logout(idUser: Int){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(idUser: idUser) { response in
            switch response.result {
            case .success(let data):
                print("Выход с системы прошел успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Register and change data
    
    private func register(newUser: NewUser){
        let userData = requestFactory.makeUserDataRequestFactory()
        userData.register(newUser: newUser) {response in
            switch response.result {
            case .success(let data):
                print("Регистрация прошла успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func changeData(newUser: NewUser){
        let userData = requestFactory.makeUserDataRequestFactory()
        userData.changeData(newUser: newUser) {response in
            switch response.result {
            case .success(let data):
                print("Регистрационные данные изменены успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get catalog and product
    
    private func getCatalogData(idCategory: Int){
        let productData = requestFactory.makeProductRequestFactory()
        productData.getCatalogData(idCategory: idCategory) {response in
            switch response.result {
            case .success(let data):
                print("Каталог товаров категории \(data.catalog[0].idCategory) с сервера выкачан успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    private func getOneProduct(idProduct: Int){
        let productData = requestFactory.makeProductRequestFactory()
        productData.getProductById(idProduct:idProduct) {response in
            switch response.result {
            case .success(let data):
                print("Один товар с сервера выкачан успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Work with comments
    
    private func getCommentList(idProduct: Int, completion: @escaping (OneProduct?)-> Void) {
        let сomments = requestFactory.makeCommentRequestFactory()
        сomments.getCommentList(idProduct:idProduct) {response in
            switch response.result {
            case .success(let data):
                completion(data)
                print("С сервера извлечены все данные по товару, в т.ч. комментарии. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func setNewComment(newComment: NewComment, completion: @escaping (Bool)-> Void){
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
    
    private func deleteComment(idProduct: Int, idComment: UUID){
        let comments = requestFactory.makeCommentRequestFactory()
        comments.deleteComment(idProduct: idProduct, idComment: idComment) {response in
            switch response.result {
            case .success(let data):
                print("Комментарий удален успешно. Полученен ответ: ", data, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Work with basket
    
    private func addProductsBasket(productToAdd: AddProductToBasketRequest, completion: @escaping () -> Void){
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
    
    private func deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest, completion: @escaping () -> Void){
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
    
    private func payBasket(amountFundsOnAccount: Int){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.payBasket(amountFundsOnAccount:amountFundsOnAccount, costOfDelivery: 0) {response in
            switch response.result {
            case .success(let data):
                print("Товар оплачен успешно. У Вас на счету осталось: ", data.amountFundsOnAccount, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getBasket(completion: @escaping () -> Void){
        let basket = requestFactory.makeBasketRequestFactory()
        basket.getBasket() {response in
            switch response.result {
            case .success(let data):
                print("Запрос на получение корзины выполнен успешно. Получен ответ: ", data, "\n")
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}
