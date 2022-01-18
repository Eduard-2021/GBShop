//
//  ConvertingImageToDataFormat.swift
//  GBShop
//
//  Created by Eduard on 09.01.2022.
//

import UIKit

class ConvertingImageToDataFormat {
    func convertData(imageFileNames: [String], complition: @escaping ([Data]?) -> Void) {
        let serialQueue = DispatchQueue(label: "queue", qos: .utility, attributes: [], autoreleaseFrequency: .workItem, target: nil)
        
        var imagesToDataFormat = [Data]()
        let dispatchGroup = DispatchGroup()


        for name in imageFileNames {
            guard let image = UIImage(named: name) else {return}
            serialQueue.async(group: dispatchGroup) {
                guard let data = image.jpegData(compressionQuality: 1) else {return}
                imagesToDataFormat.append(data)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
                complition(imagesToDataFormat)
        }
    }
}
