//
//  CollectionViewCellForMainVC.swift
//  GBShop
//
//  Created by Eduard on 09.01.2022.
//

import UIKit

class CollectionViewCellForMainVC: UICollectionViewCell {
    
    var delegate: MessageProductPlacedBasketProtocol?
    var product: OneProduct?

    @IBOutlet weak var productPictureImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var typeMeasureLabel: UILabel!
    
    @IBAction func buyButtonAction(_ sender: Any) {
        guard let product = product else {return}
        delegate?.messageProductPlacedBasket(product: product)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configButton()
    }

    private func configButton() {
        let widthButton = buyButton.frame.width
        buyButton.layer.cornerRadius = widthButton / 15
    }
    
    func config(oneProduct: OneProduct){
        product = oneProduct
        productPictureImageView.image = UIImage(data: oneProduct.productImage)
        productName.text = oneProduct.productName
        costLabel.text = String(oneProduct.productPrice)
        currencyLabel.text = "₴"
        typeMeasureLabel.text = "шт"

    }
    
}
