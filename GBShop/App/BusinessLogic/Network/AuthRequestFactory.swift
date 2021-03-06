//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(phoneNumber: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func login(email: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
