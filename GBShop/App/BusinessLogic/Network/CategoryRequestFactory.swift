//
//  CategoryFactory.swift
//  GBShop
//
//  Created by Eduard on 16.01.2022.
//



import Foundation
import Alamofire

protocol CategoryRequestFactory {
    func uploadCategoryToServer(category: Category, completionHandler: @escaping (AFDataResponse<UploadCategoryResult>) -> Void)
    
    func getAllCategories(completionHandler: @escaping (AFDataResponse<[Category]>) -> Void)
}



