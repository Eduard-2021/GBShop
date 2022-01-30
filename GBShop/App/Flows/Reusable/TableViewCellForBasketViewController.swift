//
//  TableViewCellForBasketViewController.swift
//  GBShop
//
//  Created by Eduard on 25.01.2022.
//

import UIKit

class TableViewCellForBasketViewController: UITableViewCell {
    
    var delegate: BasketViewController?
    var product: (OneProduct, Int)?
    
    let workWithBasket = WorkWithBasket()
    
    @IBOutlet weak var productImageUIView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var typeMeasureLabel: UILabel!
    @IBOutlet weak var numberOfProductLabel: UILabel!
    @IBOutlet weak var typeMeasure2Label: UILabel!
    @IBOutlet weak var removeProductButtonOutlet: UIButton!
    @IBOutlet weak var addProductButtonOutlet: UIButton!
    @IBOutlet weak var trashButtonOtlet: UIButton!
    @IBOutlet weak var bigCostLabel: UILabel!
    @IBOutlet weak var bigCurrencyLabel: UILabel!
    
    
    
    @IBAction func removeProductButton(_ sender: Any) {
        guard
            let delegate = delegate,
            let product = product else {return}
        
        if let index = delegate.selectedProducts.firstIndex(where: {$0.0.idProduct == product.0.idProduct}) {
            if delegate.selectedProducts[index].1 > 0 {
                delegate.selectedProducts[index].1 -= 1
                workWithBasket.deleteProductsBasket(
                    productToDelete: DeleteProductFromBasketRequest(idProduct: delegate.selectedProducts[index].0.idProduct,
                                                                    productsNumber: 1)){
                                                                        DispatchQueue.main.async {
                                                                            self.delegate?.refrashTableView()
                                                                        }
                                                                    }
            }
        }
            // Constant.shared.selectedProducts = delegate.selectedProducts //работа через Singlton
            
    }
    
    @IBAction func addProductButton(_ sender: Any) {
        guard
            let delegate = delegate,
            let product = product else {return}
        
        if let index = delegate.selectedProducts.firstIndex(where: {$0.0.idProduct == product.0.idProduct}) {
                delegate.selectedProducts[index].1 += 1
            workWithBasket.addProductsBasket(productToAdd: AddProductToBasketRequest(
                idProduct: delegate.selectedProducts[index].0.idProduct,
                productsNumber: 1)){
                    DispatchQueue.main.async {
                        self.delegate?.refrashTableView()
                    }
                }
            
        }
//            Constant.shared.selectedProducts = delegate.selectedProducts //работа через Singlton
//            delegate.refrashTableView()
        
    }
    
    @IBAction func trashButton(_ sender: Any) {
        guard
            let delegate = delegate,
            let product = product else {return}
        
        if let index = delegate.selectedProducts.firstIndex(where: {$0.0.idProduct == product.0.idProduct}) {
//            delegate.selectedProducts.remove(at: index)
            workWithBasket.deleteProductsBasket(productToDelete: DeleteProductFromBasketRequest(
                idProduct: delegate.selectedProducts[index].0.idProduct,
                productsNumber: delegate.selectedProducts[index].1)){
                    delegate.selectedProducts.remove(at: index)
                    DispatchQueue.main.async {
                        self.delegate?.refrashTableView()
                    }
                }
//            Constant.shared.selectedProducts = delegate.selectedProducts //работа через Singlton
//            delegate.refrashTableView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(selectedProduct: (OneProduct, Int)) {
        product = selectedProduct
        productImageUIView.image = UIImage(data: selectedProduct.0.productImage)
        productNameLabel.text = selectedProduct.0.productName
        productCostLabel.text = String(selectedProduct.0.productPrice)
        currencyLabel.text = "₴"
        typeMeasureLabel.text = "шт"
        numberOfProductLabel.text = String(selectedProduct.1)
        typeMeasure2Label.text = "шт"
        bigCostLabel.text = String(selectedProduct.0.productPrice * selectedProduct.1)
        bigCurrencyLabel.text = "₴"
        
        removeProductButtonOutlet.setTitle("", for: .normal)
        addProductButtonOutlet.setTitle("", for: .normal)
        trashButtonOtlet.setTitle("", for: .normal)
        
        removeProductButtonOutlet.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        addProductButtonOutlet.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
    }
}
