//
//  OneComment.swift
//  GBShop
//
//  Created by WorkUser2 on 16.12.2021.
//

import Foundation

struct OneComment: Codable {
    let idComment: UUID
    let commentatorName: String
    let commentDate: String
    let comment: String
    let score: Double
    let liked: String
    let noLiked: String
    let userExperienсe: String

}


