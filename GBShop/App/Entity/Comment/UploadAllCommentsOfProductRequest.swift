//
//  UploadAllCommentsOfProductRequest.swift
//  GBShop
//
//  Created by Eduard on 16.01.2022.
//

import UIKit

struct UploadAllCommentsOfProductRequest: Codable {
    var idProduct: Int
    var commentatorsNames: [String]
    var commentDate: [String]
    var comments: [String]
}
