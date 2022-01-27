//
//  Category.swift
//  GBShop
//
//  Created by Eduard on 16.01.2022.
//

import Foundation
import Alamofire

class CategoryClass: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension CategoryClass: CategoryRequestFactory {
    
    func uploadCategoryToServer(category: Category, completionHandler: @escaping (AFDataResponse<UploadCategoryResult>) -> Void){
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = UploadCategoryToServer(baseUrl: baseUrl)
        
        self.upload(
            multipartFormData:{ multipartFormData in
                guard let idCategory = category.idCategory.description.data(using: .utf8)
                else {return}
                 
                multipartFormData.append(idCategory, withName: "idCategory")
                multipartFormData.append(category.categoryName.data(using: .utf8, allowLossyConversion: false)!, withName: "categoryName")
                multipartFormData.append(category.categoryImage, withName: requestModel.key)
            },
            to: requestModel,
            completionHandler: completionHandler)
    }
    
    func getAllCategories(completionHandler: @escaping (AFDataResponse<[Category]>) -> Void){
        guard let baseUrl = Constant.shared.baseURL else {return}
        let requestModel = GetAllCategories(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension CategoryClass {
    
    struct UploadCategoryToServer: URLConvertible {
        let baseUrl: URL
        let path: String = "uploadCategoryToServer"
        func asURL() throws -> URL {
            return baseUrl.appendingPathComponent(path)
        }
        let key = "categoryImage"
    }
    
    
    struct GetAllCategories: RequestRouter {
        var parameters: Parameters?
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getAllCategories"
    }
}


/*
//
//Multiple commands produce '/Users/eduard/Library/Developer/Xcode/DerivedData/GBShop-erqoaxmybiyhqtetvcwebllgeljo/Build/Intermediates.noindex/GBShop.build/Debug-iphonesimulator/GBShop.build/Objects-normal/arm64/Category.stringsdata':
//1) Target 'GBShop' (project 'GBShop') has compile command for Swift source files
//2) Target 'GBShop' (project 'GBShop') has compile command for Swift source files

*/
