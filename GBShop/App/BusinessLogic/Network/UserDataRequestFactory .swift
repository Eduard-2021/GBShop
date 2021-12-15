//
//  UserRequestFactory .swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

protocol UserDataRequestFactory {
    func register(newUser: NewUser, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void)
    
    func changeData(newUser: NewUser, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void)
}
