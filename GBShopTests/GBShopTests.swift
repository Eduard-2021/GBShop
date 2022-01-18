
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
        let result: String
        let user: NewUser
        let authToken: String
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
    
    struct ProductCatalogStub: Codable {
        var catalog: [OneProduct]
    }

    
    struct OneProductStub: Codable {
        let idProduct: Int
        let productName: String
        let productPrice: Int
        let productDescription: String
        var commentList: [OneComment]
        let idCategory: Int
    }
    
    struct NewCommentResultStub: Codable {
        let result: Int
    }
    
    struct DeleteCommentResultStub: Codable {
        let result: Int
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
        var parameters: Parameters? {
            ["userName": "Somebody",
             "password" : "mypassword"
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/login", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<LoginResultStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.user.idUser != 0) || (data.user.userName != "") || (data.user.email != "") {
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
        var parameters: Parameters? {
            ["idUser": 123
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/logout", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<LogoutResultStub, AFError>) in
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
        var parameters: Parameters? {
            ["idUser": 123,
             "userName": "Somebody",
             "password": "mypassword",
             "email": "some@some.ru",
             "gender": "m",
             "creditCard": "9872389-2424-234224-234",
             "bio": "This is good! I think I will switch to another language"
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/register", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<RegisterResultStub, AFError>) in
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
        
        var parameters: Parameters? {
            ["idUser": 123,
             "userName": "Somebody",
             "password": "mypassword",
             "email": "some@some.ru",
             "gender": "m",
             "creditCard": "9872389-2424-234224-234",
             "bio": "This is good! I think I will switch to another language"
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/changeUserData", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<ChangeDataResultStub, AFError>) in
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
        
        var parameters: Parameters? {
            ["idCategory": 2
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/getCatalogData", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<ProductCatalogStub, AFError>) in
            switch response.result {
                case .success(let data):

                if (data.catalog[0].idProduct != 222) || (data.catalog[0].productName != "Холодильник") || (data.catalog[0].productDescription != "Новая модель") || (data.catalog[0].productPrice != 55000) ||  (data.catalog[0].idCategory != 2) {
                    XCTFail()
                }
                case .failure(_):
                    XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
        
    
    func testGetProductById() {
        var parameters: Parameters? {
            ["idProduct": 123
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/getProductById", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<OneProductStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.idProduct != 123) || (data.productName != "Ноутбук") || (data.productPrice != 45600) || (data.productDescription != "Мощный игровой ноутбук") || (data.idCategory != 1){
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetCommentList() {
        var parameters: Parameters? {
            ["idProduct": 123
            ]
        }
        AF.request("http://secret-escarpment-71481.herokuapp.com/getCommentList", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) {(response: DataResponse<OneProductStub, AFError>) in
            switch response.result {
                case .success(let data):
                if (data.commentList.count == 0) {
                    XCTFail()
                }
                break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCreateNewComment() {
        var parameters: Parameters? {
            ["idProduct": 123,
             "commentatorName": "Семен",
             "commentDate": "15.12.21",
             "comment": "Ненадежный комп"
            ]
        }

        AF.request("http://secret-escarpment-71481.herokuapp.com/createNewComment", method: .post, parameters: parameters).responseCodable(errorParser: self.errorParser) {(response: DataResponse<NewCommentResultStub, AFError>) in
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
    
    func testDeleteComment() {
        
        var parametersForGet: Parameters? {
            ["idProduct": 123
            ]
        }
        
        AF.request("http://secret-escarpment-71481.herokuapp.com/getCommentList", method: .post, parameters: parametersForGet).responseCodable(errorParser: errorParser) {(response: DataResponse<OneProductStub, AFError>) in
            switch response.result {
                case .success(let data):
                guard let commentUUID = data.commentList.last?.idComment
                else {
                    XCTFail()
                    return
                }
                    var parameters: Parameters? {
                        ["idProduct": 123,
                         "idComment":  commentUUID
                        ]
                    }

                    AF.request("http://secret-escarpment-71481.herokuapp.com/deleteComment", method: .post, parameters: parameters).responseCodable(errorParser: self.errorParser) {(response: DataResponse<DeleteCommentResultStub, AFError>) in
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
                break
                case .failure: XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testGetBasket() {

        AF.request("http://secret-escarpment-71481.herokuapp.com/getBasket", method: .post).responseCodable(errorParser: self.errorParser) {(response: DataResponse<NewCommentResultStub, AFError>) in
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
    
    
    

    func testExample() throws {

    }

}

