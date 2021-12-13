//
//  LoginResult.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: String
    let user: User
    let authToken: String
}
