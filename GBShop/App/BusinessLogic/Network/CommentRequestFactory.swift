//
//  CommentRequestFactory.swift
//  GBShop
//
//  Created by Eduard on 18.12.2021.
//

import Foundation
import Alamofire

protocol CommentRequestFactory {
    
    func getCommentList(idProduct: Int, completionHandler: @escaping (AFDataResponse<OneProduct>) -> Void)
    
    func createNewComment(newComment: NewComment, completionHandler: @escaping (AFDataResponse<NewCommentResult>) -> Void)
    
    func deleteComment(idProduct: Int, idComment: UUID, completionHandler: @escaping (AFDataResponse<NewCommentResult>) -> Void)
    
}
