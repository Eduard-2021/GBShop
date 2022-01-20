//
//  CreateAndLoadProductsToServer.swift
//  GBShop
//
//  Created by Eduard on 11.01.2022.
//

import UIKit

class CreateAndLoadProductsToServer {
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    let convertingImageToDataFormat = ConvertingImageToDataFormat()
    
    //Этот метод должен быть в отдельном приложение, которое обновляет данные на сервере
    func upLoadProductsWithImagesToServer(completion: @escaping () -> Void) {
        
        convertingImageToDataFormat.convertData(imageFileNames: ["Пасха1","Грудинка","Тушенка", "КремСыр", "ХлебКулиничи", "Пасха2", "Корм Royal", "Миндаль", "Пиво Балтика", "Пиво KRONEN", "Подарки1","Подарки2","Фрукты2","Фрукты1","Бакалея2","Бакалея1","Напитки2","Напитки1",]) { [weak self] (imagesOfProductInDataFormat) in
            
            guard let self = self, let imagesOfProductInDataFormat = imagesOfProductInDataFormat else {
//                complite()
                return
            }
            
            let products = [
            OneProduct(idProduct: 10,
                       productName: "Пасха Santagelo Panettone",
                       productPrice: 156,
                       productDescription: "Страна производитель - Италия. Вес - 500 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Антон",
                            commentDate: "12.12.21",
                            comment: "Вкусная пасха",
                            score: 4.5,
                            liked: "Понравился запах",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 4,
                       productImage: imagesOfProductInDataFormat[0],
                       promotion: 0
                       ),
            OneProduct(idProduct: 11,
                       productName: "Грудинка свинная",
                       productPrice: 276,
                       productDescription: "Дымное мясо от Тараса. Копченое. Страна производитель - Украина. Вес - 800 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Алина",
                            commentDate: "22.12.21",
                            comment: "Очень рекомендую",
                            score: 5.0,
                            liked: "Вкус не повторимый",
                            noLiked: "",
                            userExperienсe:"Месяц"
                        )
                       ],
                       idCategory: 3,
                       productImage: imagesOfProductInDataFormat[1],
                       promotion: 0
                       ),
            OneProduct(idProduct: 12,
                       productName: "Тушенка",
                       productPrice: 104,
                       productDescription: "Дымное мясо от Тараса. Копченое. Страна производитель - Украина. Вес - 500 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Леонид",
                            commentDate: "10.12.21",
                            comment: "Интересное решение",
                            score: 4.0,
                            liked: "Мясо хорошего качества",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 3,
                       productImage: imagesOfProductInDataFormat[2],
                       promotion: 0
                       ),
            OneProduct(idProduct: 13,
                       productName: "Крем сыр Saint Agur",
                       productPrice: 149,
                       productDescription: "Страна производитель - Франция. Вес - 150 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Катя",
                            commentDate: "01.12.21",
                            comment: "Сыр не плохой, но дорогой",
                            score: 3.5,
                            liked: "Понравился запах",
                            noLiked: "Дорого",
                            userExperienсe:"10 дней")
                       ],
                       idCategory: 5,
                       productImage: imagesOfProductInDataFormat[3],
                       promotion: 0
                       ),
            OneProduct(idProduct: 14,
                       productName: "Хлеб Кулиничи",
                       productPrice: 26,
                       productDescription: "Страна производитель - Украина. Вес - 350 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Лена",
                            commentDate: "02.12.21",
                            comment: "Вкусно",
                            score: 4.5,
                            liked: "Хорошо пропеченный",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 8,
                       productImage: imagesOfProductInDataFormat[4],
                       promotion: 0
                       ),
            OneProduct(idProduct: 15,
                       productName: "Пасха Santagelo Pandoro",
                       productPrice: 223,
                       productDescription: "Страна производитель - Италия. Вес - 450 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Сергей",
                            commentDate: "05.12.21",
                            comment: "Очень сладкая!",
                            score: 5.0,
                            liked: "Понравился вкус",
                            noLiked: "",
                            userExperienсe:"Одна неделя")
                       ],
                       idCategory: 6,
                       productImage: imagesOfProductInDataFormat[5],
                       promotion: 0
                       ),
            OneProduct(idProduct: 16,
                       productName: "Корм Royal Canin сухой",
                       productPrice: 463,
                       productDescription: "Корм Royal Canin сухой Giant Adult. Страна производитель - Италия. Вес - 4 кг",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Сергей",
                            commentDate: "15.12.21",
                            comment: "Дорогой, но хороший корм",
                            score: 4.0,
                            liked: "Кошки в восторге",
                            noLiked: "",
                            userExperienсe:"1 год")
                       ],
                       idCategory: 7,
                       productImage: imagesOfProductInDataFormat[6],
                       promotion: 1
                       ),
            OneProduct(idProduct: 17,
                       productName: "Миндаль жаренный Winway",
                       productPrice: 50,
                       productDescription: "Миндаль жаренный Winway. Страна производитель - Украина. Вес - 100 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Анна",
                            commentDate: "17.12.21",
                            comment: "Вкусно, но мало",
                            score: 4.0,
                            liked: "Понравился запах",
                            noLiked: "Мало",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 2,
                       productImage: imagesOfProductInDataFormat[7],
                       promotion: 1
                       ),
            OneProduct(idProduct: 18,
                       productName: "Пиво БАЛТИКА",
                       productPrice: 16,
                       productDescription: "Пиво Балтика №7 светлое. Страна производитель - Украина. Вес - 500 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Роман",
                            commentDate: "17.12.21",
                            comment: "Отличное пиво",
                            score: 5.0,
                            liked: "Нравится вкус",
                            noLiked: "",
                            userExperienсe:"Много лет")
                       ],
                       idCategory: 6,
                       productImage: imagesOfProductInDataFormat[8],
                       promotion: 1
                       ),
            OneProduct(idProduct: 19,
                       productName: "Пиво KRONENBOURG",
                       productPrice: 24,
                       productDescription: "Пиво KRONENBOURG 1664 Blanc. Страна производитель - Украина. Вес - 500 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Денис",
                            commentDate: "17.12.21",
                            comment: "Это пиво очень нравится",
                            score: 4.5,
                            liked: "Благородный вкус",
                            noLiked: "",
                            userExperienсe:"Месяц")
                       ],
                       idCategory: 1,
                       productImage: imagesOfProductInDataFormat[9],
                       promotion: 1
                       ),
            OneProduct(idProduct: 20,
                       productName: "Виски Jack Daniel's",
                       productPrice: 720,
                       productDescription: "Виски Jack Daniel's c двумя стаканами. Страна производитель - Дания. Вес - 750 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Петр",
                            commentDate: "17.12.21",
                            comment: "Класс!",
                            score: 4.0,
                            liked: "Мое любимое",
                            noLiked: "",
                            userExperienсe:"Много лет")
                       ],
                       idCategory: 12,
                       productImage: imagesOfProductInDataFormat[10],
                       promotion: 1
                       ),
            OneProduct(idProduct: 21,
                       productName: "Подарочный набор Ореховый БУМ",
                       productPrice: 299,
                       productDescription: "Подарочный набор Ореховый БУМ. Страна производитель - Украина. Вес - 560 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Анна",
                            commentDate: "20.12.21",
                            comment: "Рекомендую на Новый год!",
                            score: 4.5,
                            liked: "Красиво упакован",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 12,
                       productImage: imagesOfProductInDataFormat[11],
                       promotion: 1
                       ),
            OneProduct(idProduct: 22,
                       productName: "Апельсин фреш",
                       productPrice: 35,
                       productDescription: "Апельсин фреш. Страна производитель - Бразилия. Вес - 1 кг",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Семен",
                            commentDate: "21.12.21",
                            comment: "Рекомендую на Новый год!",
                            score: 4.0,
                            liked: "Понравился запах",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 11,
                       productImage: imagesOfProductInDataFormat[12],
                       promotion: 0
                       ),
            OneProduct(idProduct: 23,
                       productName: "Груша Парижанка",
                       productPrice: 35,
                       productDescription: "Груша Парижанка. Страна производитель - Украина. Вес - 1 кг",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Катя",
                            commentDate: "22.12.21",
                            comment: "Немного кисловата",
                            score: 3.5,
                            liked: "",
                            noLiked: "Кисловата",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 11,
                       productImage: imagesOfProductInDataFormat[13],
                       promotion: 0
                       ),
            OneProduct(idProduct: 24,
                       productName: "Вермишель фунчоза",
                       productPrice: 38,
                       productDescription: "Вермишель фунчоза. Ямчан. Страна производитель - Украина. Вес - 100 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Елена",
                            commentDate: "24.12.21",
                            comment: "Отлично подхоит для супа",
                            score: 4.0,
                            liked: "Хорошо варится",
                            noLiked: "Дороговато",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 10,
                       productImage: imagesOfProductInDataFormat[14],
                       promotion: 0
                       ),
            OneProduct(idProduct: 25,
                       productName: "Чечевица Pere",
                       productPrice: 38,
                       productDescription: "Чечевица Pere Зеленая. Страна производитель - Украина. Вес - 400 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Оксана",
                            commentDate: "26.12.21",
                            comment: "Знаю, что полезна",
                            score: 4.5,
                            liked: "Понравился запах",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 60,
                       productImage: imagesOfProductInDataFormat[15],
                       promotion: 0
                       ),
            OneProduct(idProduct: 26,
                       productName: "Вода питьевая",
                       productPrice: 26,
                       productDescription: "Вода питьевая родниковая. Страна производитель - Украина. Вес - 1000 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Оксана",
                            commentDate: "27.12.21",
                            comment: "Очень чистая",
                            score: 4.5,
                            liked: "",
                            noLiked: "",
                            userExperienсe:"Месяц")
                       ],
                       idCategory: 9,
                       productImage: imagesOfProductInDataFormat[16],
                       promotion: 1
                       ),
            OneProduct(idProduct: 27,
                       productName: "Смузи Body and Future",
                       productPrice: 39,
                       productDescription: "Смузи Body and Future Vital Energy. Страна производитель - Украина. Вес - 500 г",
                       commentList: [
                        OneComment(
                            idComment: UUID(),
                            commentatorName: "Ангелина",
                            commentDate: "28.12.21",
                            comment: "Очень вкусное",
                            score: 5.0,
                            liked: "Понравился запах",
                            noLiked: "",
                            userExperienсe:"Один день")
                       ],
                       idCategory: 9,
                       productImage: imagesOfProductInDataFormat[17],
                       promotion: 1
                       ),
            
            ]

            self.authRegistrationAndWorkWithProducts.upLoadProducts(products: products) {_ in
    
                var newComments = [NewComment]()
                
                for product in products {
                    for comment in product.commentList {
                        newComments.append(NewComment(
                            idProduct: product.idProduct,
                            commentatorName: comment.commentatorName,
                            commentDate: comment.commentDate,
                            comment: comment.comment,
                            score: comment.score,
                            liked: comment.liked,
                            noLiked: comment.noLiked,
                            userExperienсe: comment.userExperienсe
                        )
                        )
                    }
                }
                    
                var isAllCommentsUpload = false
                var isNowUploading = false
                var commentNumber = 0
                
                if !newComments.isEmpty {
                    while !isAllCommentsUpload {
                        if (!isNowUploading) && (commentNumber < newComments.count ){
                            isNowUploading = true
                            self.authRegistrationAndWorkWithProducts.createNewComment(newComment: newComments[commentNumber]) { _ in
                                commentNumber += 1
                                isNowUploading = false
                                if commentNumber == newComments.count {
                                    isAllCommentsUpload = true
                                    completion()
                                }
                            }
                        }
                    }
                }
                else {
                    completion()
                    return
                }
            }
        }
    }
}
                
