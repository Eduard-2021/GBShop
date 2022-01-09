//
//  Constant.swift
//  GBShop
//
//  Created by Eduard on 27.12.2021.
//

import Foundation

class Constant {
    private init(){}
    static let shared = Constant()
    let countryDialingCodes = [("Russia","+7","FlagRUS.png"), ("Ukraine","+380","FlagUA.png")]
    var numberOfUsers = 0
    var isAuth = false
    var user: NewUser?
//    var url = "http://127.0.0.1:8080/"
    var baseURL: URL?
}

