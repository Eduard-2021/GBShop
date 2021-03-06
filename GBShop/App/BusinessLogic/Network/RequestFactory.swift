//
//  RequestFactory.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeUserDataRequestFactory() -> UserDataRequestFactory {
        let errorParser = makeErrorParser()
        return UserData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeProductRequestFactory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
        return ProductData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCommentRequestFactory() -> CommentRequestFactory {
        let errorParser = makeErrorParser()
        return Comments(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeBasketRequestFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCategoryRequestFactory() -> CategoryRequestFactory {
        let errorParser = makeErrorParser()
        return CategoryClass(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

}
