//
//  ViewController.swift
//  GBShop
//
//  Created by Eduard on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newUser = NewUser(idUser: 123,
                              userName: "Somebody",
                              password: "mypassword",
                              email: "some@some.ru",
                              gender: "m",
                              creditCard: "9872389-2424-234224-234",
                              bio: "This is good! I think I will switch to another language")
        
        login(userName: "Somebody", password: "mypassword")
        print()
        logout(idUser: 123)
        register(newUser: newUser)
        changeData(newUser: newUser)
        getCatalogData(pageNumber: 1, idCategory: 1)
        getProduct(idProduct: 123)
        
    }

    func login(userName: String, password: String){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: userName, password: password) { response in
            switch response.result {
            case .success(let login):
                print(login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout(idUser: Int){
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(idUser: idUser) { response in
            switch response.result {
            case .success(let login):
                print(login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func register(newUser: NewUser){
        let userData = requestFactory.makeUserDataRequestFatory()
        userData.register(newUser: newUser) {response in
            switch response.result {
            case .success(let login):
                print(login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeData(newUser: NewUser){
        let userData = requestFactory.makeUserDataRequestFatory()
        userData.changeData(newUser: newUser) {response in
            switch response.result {
            case .success(let login):
                print(login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCatalogData(pageNumber: Int, idCategory: Int){
        var catalogData = [OneItemOfCatalogData]()
        let productRequestFactory = requestFactory.makeProductRequestFactory()
        productRequestFactory.getCatalogData(pageNumber: pageNumber, idCategory: idCategory) {data in
            guard let data = data else {
                print("Ошибка")
                return
            }
            
            if let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))) as? [[String : AnyObject]] {
                for item in json {
                    let oneItem = OneItemOfCatalogData(idProduct: item[OneItemOfCatalogData.fieldName.idProduct.rawValue] as! Int, productName: item[OneItemOfCatalogData.fieldName.productName.rawValue] as! String, price: item[OneItemOfCatalogData.fieldName.price.rawValue] as! Int)
                    catalogData.append(oneItem)
                }
            }
            print("\n", catalogData, "\n")
        }
    }
    
    
    func getProduct(idProduct: Int){
        let productData = requestFactory.makeProductRequestFactory()
        productData.getGoodById(idProduct:idProduct) {response in
            switch response.result {
            case .success(let login):
                print(login, "\n")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

