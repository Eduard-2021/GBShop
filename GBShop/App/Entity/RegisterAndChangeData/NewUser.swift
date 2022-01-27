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
    let phoneNumber: String
    let gender: String
    let creditCard: String
    let bio: String
}
