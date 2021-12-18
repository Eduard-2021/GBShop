//
// NewUser.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation

struct NewUser: Codable {
    let idUser: Int
    let userName: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id_user"
//        case userName = "username"
//        case password = "password"
//        case email = "email"
//        case gender = "gender"
//        case creditCard = "credit_card"
//        case bio = "bio"
//
//    }
}
