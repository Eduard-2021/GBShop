//
//  Comments.swift
//  GBShop
//
//  Created by WorkUser2 on 16.12.2021.
//

import Foundation
import Alamofire

class Comments: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
//    let baseUrl = URL(string: "http://secret-escarpment-71481.herokuapp.com/")!
    
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Comments: CommentRequestFactory {
    func getCommentList(idProduct: Int, completionHandler: @escaping (AFDataResponse<OneProduct>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetCommentList(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func createNewComment(newComment: NewComment, completionHandler: @escaping (AFDataResponse<NewCommentResult>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = CreateNewComment(baseUrl: baseUrl, newComment: newComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func uploadAllCommentsOfProduct(allCommentsOfProduct: UploadAllCommentsOfProductRequest, completionHandler: @escaping (AFDataResponse<NewCommentResult>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = AllCommentsOfProduct(baseUrl: baseUrl, allCommentsOfProduct: allCommentsOfProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteComment(idProduct: Int, idComment: UUID, completionHandler: @escaping (AFDataResponse<NewCommentResult>) -> Void) {
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = DeleteComment(baseUrl: baseUrl, idProduct: idProduct, idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
  
}

extension Comments {
    struct GetCommentList: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getCommentList"
        
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "idProduct" : idProduct,
            ]
        }
    }
    
    struct CreateNewComment: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "createNewComment"
        
        let newComment: NewComment
        var parameters: Parameters? {
            return [
                "idProduct" : newComment.idProduct,
                "commentatorName": newComment.commentatorName,
                "commentDate": newComment.commentDate,
                "comment": newComment.comment,
                "score": newComment.score,
                "liked": newComment.liked,
                "noLiked": newComment.noLiked,
                "userExperienсe": newComment.userExperienсe
            ]
        }
    }
    
    struct AllCommentsOfProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "uploadAllCommentsOfProduct"
        
        let allCommentsOfProduct: UploadAllCommentsOfProductRequest
        var parameters: Parameters? {
            return [
                "idProduct" : allCommentsOfProduct.idProduct,
                "commentatorsNames": allCommentsOfProduct.commentatorsNames,
                "commentDate": allCommentsOfProduct.commentDate,
                "comments": allCommentsOfProduct.comments
//                "score": newComment.score,
//                "liked": newComment.liked,
//                "noLiked": newComment.noLiked,
//                "userExperienсe": newComment.userExperienсe
            ]
        }
    }
    
    
    struct DeleteComment: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteComment"
        
        let idProduct: Int
        let idComment: UUID
        var parameters: Parameters? {
            return [
                "idProduct" : idProduct,
                "idComment": idComment,
            ]
        }
    }
    
}
