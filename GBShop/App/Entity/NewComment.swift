//
//  NewComment.swift
//  GBShop
//
//  Created by WorkUser2 on 16.12.2021.
//

import Foundation

struct NewComment: Codable {
    let idProduct: Int
    let commentatorName: String
    let commentDate: String
    let comment: String
}
