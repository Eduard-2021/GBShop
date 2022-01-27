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
    //let baseUrl = URL(string: "http://secret-escarpment-71481.herokuapp.com/")!
    
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
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = Logout(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(phoneNumber: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = LoginViaPhoneNumber(baseUrl: baseUrl, login: phoneNumber, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(email: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = LoginViaEmail(baseUrl: baseUrl, login: email, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct LoginViaPhoneNumber: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "loginViaPhoneNumber"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "phoneNumber": login,
                "password": password
            ]
        }
    }
    
    struct LoginViaEmail: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "loginViaEmail"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "email": login,
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
