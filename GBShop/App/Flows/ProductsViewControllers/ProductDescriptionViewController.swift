//
//  ProductViewViewController.swift
//  GBShop
//
//  Created by Eduard on 19.01.2022.
//

import UIKit

class ProductDescriptionViewController: UIViewController, Storyboardable, MessageProductPlacedBasketProtocol  {
    
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    var coordinator: DescriptionAndReviewsProtocol?
    var product: OneProduct? = nil
    var isBuyButtonPressed = false
    let workWithBasket = WorkWithBasket()
    
    @IBOutlet weak var aboutProductButtonOutlet: UIButton!
    @IBOutlet weak var vendorCodeLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var carencyLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    @IBAction func reviewsButton(_ sender: Any) {
        guard let product = product else {return}
        coordinator?.openProductReviewsViewController(product: product)
    }
    
    @IBAction func buyButton(_ sender: Any) {
        guard let product = product else {return}
        messageProductPlacedBasket(product: product)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {return}
        vendorCodeLabel.text = "Артикул: \(product.idProduct)"
        productImageView.image = UIImage(data: product.productImage)
        productNameLabel.text = product.productName
        costLabel.text = String(product.productPrice)
        carencyLabel.text = "₴"
        unitLabel.text = "за шт"
        descriptionLabel.text = product.productDescription
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func messageProductPlacedBasket(product: OneProduct) {
        if !isBuyButtonPressed {
            
            /*
            //Работа с использованием синглтона для формирования корзины
            if let index = Constant.shared.selectedProducts.firstIndex(where: {$0.0.idProduct == product.idProduct}) {
                Constant.shared.selectedProducts[index].1 += 1
            } else {
                Constant.shared.selectedProducts.append((product,1))
            }
             */
            
            workWithBasket.addProductsBasket(
                productToAdd: AddProductToBasketRequest(idProduct: product.idProduct, productsNumber: 1)){}
            
            isBuyButtonPressed = true
            let messageLabel = UILabel()
            let highOfMessage: CGFloat = 40
            let edgeDistanceForMessage: CGFloat = 20
            let liftingHighOfMessage: CGFloat = 145
            let cornerRadius: CGFloat = 13
            
            messageLabel.backgroundColor = .gray
            messageLabel.textColor = .white
            messageLabel.text = "   Товар добавлен в конзину"
            messageLabel.frame = CGRect(x: edgeDistanceForMessage, y: view.bounds.height + highOfMessage, width: self.view.bounds.width - edgeDistanceForMessage*2, height: highOfMessage)
            
            messageLabel.layer.masksToBounds = true
            messageLabel.layer.cornerRadius = cornerRadius
            messageLabel.alpha = 0
            
            view.addSubview(messageLabel)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: {
                messageLabel.frame = CGRect(x: edgeDistanceForMessage, y: self.view.bounds.height - liftingHighOfMessage, width: self.view.bounds.width - edgeDistanceForMessage*2, height: highOfMessage)
                messageLabel.alpha = 1
            },
                           completion: { _ in
                UIView.animate(withDuration: 0.5,
                               delay: 2,
                               options: [.curveEaseIn],
                               animations: {
                    messageLabel.frame = CGRect(x: edgeDistanceForMessage, y: self.view.bounds.height + highOfMessage, width: self.view.bounds.width - edgeDistanceForMessage*2, height: highOfMessage)
                    messageLabel.alpha = 0
                },completion: { _ in
                    self.isBuyButtonPressed = false
                })
            })
        }
    }
    
}
