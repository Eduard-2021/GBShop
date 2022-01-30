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
    var baseURL: URL?
//    var selectedProducts = [(OneProduct, Int)]()
    var whoCalledAuth: WhoCalledAuth = .authViewController
    var account = 1000
}

enum WhoCalledAuth {
    case authViewController
    case basketViewController
    case creatingReviewViewController
}










