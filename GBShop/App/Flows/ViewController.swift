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
        
        let newUser = NewUser(id: 123,
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
}

