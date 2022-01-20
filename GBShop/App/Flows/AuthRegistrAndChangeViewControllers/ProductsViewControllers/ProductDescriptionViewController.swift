//
//  ProductViewViewController.swift
//  GBShop
//
//  Created by Eduard on 19.01.2022.
//

import UIKit

class ProductDescriptionViewController: UIViewController, Storyboardable  {
    
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    weak var coordinator: CatalogAndProductsCoordinator?
    var product: OneProduct? = nil
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {return}
        vendorCodeLabel.text = "Артикул: \(product.idProduct)"
        productImageView.image = UIImage(data: product.productImage)
        productNameLabel.text = product.productName
        costLabel.text = String(product.productPrice)
        carencyLabel.text = "₴"
        unitLabel.text = "шт"
        descriptionLabel.text = product.productDescription

    }
}
