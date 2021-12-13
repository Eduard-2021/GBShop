//
//  UserData.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

class UserData: AbstractRequestFactory {
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

extension UserData: UserDataRequestFactory {
    func register(newUser: NewUser, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl, newUser: newUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeData(newUser: NewUser, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, newUser: newUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension UserData {
    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "register"
        
        let newUser: NewUser
        var parameters: Parameters? {
            return [
                "idUser" : newUser.idUser,
                "userName" : newUser.userName,
                "password" : newUser.password,
                "email" : newUser.email,
                "gender": newUser.gender,
                "creditCard" : newUser.creditCard,
                "bio" : newUser.bio
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        
        let newUser: NewUser
        var parameters: Parameters? {
            return [
                "idUser" : newUser.idUser,
                "userName" : newUser.userName,
                "password" : newUser.password,
                "email" : newUser.email,
                "gender": newUser.gender,
                "creditCard" : newUser.creditCard,
                "bio" : newUser.bio
            ]
        }
    }
    
}
