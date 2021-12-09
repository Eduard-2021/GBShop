//
//  GBShopTests.swift
//  GBShopTests
//
//  Created by Eduard on 27.11.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GBShopTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download")
    var errorParser: ErrorParserStub!
    
    struct PostGeneralResultStub: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

    struct LoginResultStub: Codable {
        let result: Int
        let user: User
    }
    
    struct LogoutResultStub: Codable {
        let result: Int
    }
    
    struct RegisterResultStub: Codable {
        let result: Int
        let userMessage: String
    }

    
    enum ApiErrorStub: Error {
        case fatalError
    }
    
    struct ChangeDataResultStub: Codable {
        let result: Int
    }

    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }
    
    
    struct OneItemOfCatalogDataStub {
        let idProduct: Int
        let productName: String
        let price: Int
        
        enum fieldName: String {
            case idProduct = "id_product"
            case productName = "product_name"
            case price = "price"
        }
    }
    
    struct GetProductResultStub: Codable {
        let result: Int
        let productName: String
        let productPrice: Int
        let productDescription: String
        
        enum CodingKeys: String, CodingKey {
            case result = "result"
            case productName = "product_name"
            case productPrice = "product_price"
            case productDescription = "product_description"
        }
    }
    

    override func setUpWithError() throws {
        
        errorParser = ErrorParserStub()

    }

    override func tearDownWithError() throws {
        
        errorParser = nil
        
    }
    
    func testShouldDownloadAndParse_General() {
        
        AF.request("https://jsonplaceholder.typicode.com/posts/1").responseCodable(errorParser: errorParser) {(response: DataResponse<PostGeneralResultStub, AFError>) in
            switch response.result {
                case .success(_): break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogin() {
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/login.json?username=Somebody&password=mypassword").responseCodable(errorParser: errorParser) {(response: DataResponse<LoginResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.user.id != 123) || (data.user.login != "geekbrains") || (data.user.name != "John") || (data.user.lastname != "Doe") {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testLogout() {
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/logout.json?id_user=123").responseCodable(errorParser: errorParser) {(response: DataResponse<LogoutResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.result != 1) {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRegister() {
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/registerUser.json?id_user=123&username=Somebody&password=mypassword&email=some@some.ru&gender=m&credit_card=9872389-2424-234224-234&bio=This%20is%20good!%20I%20think%20I%20will%20switch%20to%20another%20language").responseCodable(errorParser: errorParser) {(response: DataResponse<RegisterResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.result != 1) || (data.userMessage != "Регистрация прошла успешно!") {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testChangeUserData() {
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/changeUserData.json?id_user=123&username=Somebody&password=mypassword&email=some@some.ru&gender=m&credit_card=9872389-2424-234224-234&bio=This%20is%20good!%20I%20think%20I%20will%20switch%20to%20another%20language").responseCodable(errorParser: errorParser) {(response: DataResponse<ChangeDataResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.result != 1) {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testGetCatalogData() {
        var catalogData = [OneItemOfCatalogDataStub]()
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/catalogData.json?page_number=1&id_category=1").responseData {response in
            switch response.result {
                case .success(let data):
                    if let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))) as? [[String : AnyObject]] {
                        for item in json {
                            let oneItem = OneItemOfCatalogDataStub(idProduct: item[OneItemOfCatalogDataStub.fieldName.idProduct.rawValue] as! Int, productName: item[OneItemOfCatalogDataStub.fieldName.productName.rawValue] as! String, price: item[OneItemOfCatalogDataStub.fieldName.price.rawValue] as! Int)
                            catalogData.append(oneItem)
                        }
                    }
                if (catalogData[0].idProduct != 123) || (catalogData[0].productName != "Ноутбук") || (catalogData[0].price != 45600) || (catalogData[1].idProduct != 456) || (catalogData[1].productName != "Мышка") || (catalogData[1].price != 1000) {
                    XCTFail()
                }
                case .failure(_):
                    XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
        
    
    func testGetGoodById() {
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/getGoodById.json?id_product=123").responseCodable(errorParser: errorParser) {(response: DataResponse<GetProductResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.result != 1) || (data.productName != "Ноутбук") || (data.productPrice != 45600) || (data.productDescription != "Мощный игровой ноутбук") {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }


    func testExample() throws {

    }

}



