//
//  AuthAndRegistration.swift
//  GBShop
//
//  Created by Eduard on 27.12.2021.
//

import UIKit

class AuthAndRegistration {
    
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
        let userData = requestFactory.makeUserDataRequestFatory()
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
        let userData = requestFactory.makeUserDataRequestFatory()
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
        let userData = requestFactory.makeUserDataRequestFatory()
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
    
    
}
