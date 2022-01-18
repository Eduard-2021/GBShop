//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Eduard on 05.12.2021.
//

import Foundation
import Alamofire

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void)
        -> DataRequest
    
    @discardableResult
    func upload<T: Decodable>(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        to url: URLConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void)
        -> UploadRequest
}

extension AbstractRequestFactory {
    
    @discardableResult
    public func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void)
        -> DataRequest {
            return sessionManager
                .request(request)
                .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func upload<T: Decodable>(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        to url: URLConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void)
        -> UploadRequest{
            return sessionManager
                .upload(multipartFormData: multipartFormData,
                        to: url)
                .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
}


