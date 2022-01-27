//
//  UploadUsingURLSessionAPI.swift
//  GBShop
//
//  Created by Eduard on 13.01.2022.
//

import Foundation
import Dispatch

extension URLSession {

    func uploadTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        uploadTask(with: request, from: request.httpBody, completionHandler: completionHandler)
    }
}

class UploadUsingURLSessionAPI {
    func upload(fileData: Data) {
    //    let fileData = try Data(contentsOf: URL(fileURLWithPath: "/Users/[user]]/[file].png"))
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/dataFromServer")!)
        request.httpMethod = "POST"
        request.httpBody = fileData
//        request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)

        let task = URLSession.shared.uploadTask(with: request) { data, response, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            guard let response = response as? HTTPURLResponse else {
                fatalError("Invalid response")
            }
            guard response.statusCode == 200 else {
                fatalError("HTTP status error: (response.statusCode)")
            }
            guard let data = data, let result = String(data: data, encoding: .utf8) else {
                fatalError("Invalid or missing HTTP data")
            }
            print(result)
            exit(0)
        }

        task.resume()
//        dispatchMain()
    }
}
