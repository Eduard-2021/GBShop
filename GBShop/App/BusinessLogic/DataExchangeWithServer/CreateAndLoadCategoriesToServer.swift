//
//  CreateAndLoadCategoriesToServer.swift
//  GBShop
//
//  Created by Eduard on 16.01.2022.
//

import Foundation

class CreateAndLoadCategoriesToServer {
 
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    let convertingImageToDataFormat = ConvertingImageToDataFormat()
    
    //Этот метод должен быть в отдельном приложение, которое обновляет данные на сервере
    func upLoadCategoriesWithImagesToServer(completion: @escaping () -> Void) {
        
        convertingImageToDataFormat.convertData(imageFileNames: ["beverages","alcohol","bread", "confectionery", "fruit", "grocery", "meat", "milk", "nuts", "presents", "sale","Корм" ]) { [weak self] (imagesOfCategoriesInDataFormat) in
            
            guard let self = self, let imagesOfCategoriesInDataFormat = imagesOfCategoriesInDataFormat else {
                completion()
                return
            }
            
            let categories = [
                Category(idCategory: 1,
                         categoryName: "Алкоголь",
                         categoryImage: imagesOfCategoriesInDataFormat[1]),
                Category(idCategory: 2,
                         categoryName: "Сухофрукты и орехи",
                         categoryImage: imagesOfCategoriesInDataFormat[8]),
                Category(idCategory: 3,
                         categoryName: "Мясо, птица",
                         categoryImage: imagesOfCategoriesInDataFormat[6]),
                Category(idCategory: 4,
                         categoryName: "Кондитерские изделия",
                         categoryImage: imagesOfCategoriesInDataFormat[3]),
                Category(idCategory: 5,
                         categoryName: "Молочные продукты",
                         categoryImage: imagesOfCategoriesInDataFormat[7]),
                Category(idCategory: 6,
                         categoryName: "Акционные товары",
                         categoryImage: imagesOfCategoriesInDataFormat[10]),
                Category(idCategory: 7,
                         categoryName: "Товары для животных",
                         categoryImage: imagesOfCategoriesInDataFormat[11]),
                Category(idCategory: 8,
                         categoryName: "Хлебобулочные изделия",
                         categoryImage: imagesOfCategoriesInDataFormat[2]),
                Category(idCategory: 9,
                         categoryName: "Напитки",
                         categoryImage: imagesOfCategoriesInDataFormat[0]),
                Category(idCategory: 10,
                         categoryName: "Бакалея",
                         categoryImage: imagesOfCategoriesInDataFormat[5]),
                Category(idCategory: 11,
                         categoryName: "Фрукты",
                         categoryImage: imagesOfCategoriesInDataFormat[4]),
                Category(idCategory: 12,
                         categoryName: "Подарочные наборы",
                         categoryImage: imagesOfCategoriesInDataFormat[9]),
            ]
            
            self.authRegistrationAndWorkWithProducts.uploadCategory(categories: categories){ result in completion()
            }
        }
    }

}
 
           
                   
                   
