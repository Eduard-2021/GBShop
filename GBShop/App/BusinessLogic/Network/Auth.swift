//
//  Auth.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "userName": login,
                "password": password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"
        
        let idUser: Int
        var parameters: Parameters? {
            return [
                "idUser": idUser
            ]
        }
    }
    
}
