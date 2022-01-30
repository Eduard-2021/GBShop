//
//  ProductsViewController.swift
//  GBShop
//
//  Created by Eduard on 18.01.2022.
//

import UIKit

class ProductsViewController: UIViewController, Storyboardable, MessageProductPlacedBasketProtocol {
    
    let convertingImageToDataFormat = ConvertingImageToDataFormat()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    var allProducts = [OneProduct]()
    let createAndLoadProductsToServer = CreateAndLoadProductsToServer()
    var isBuyButtonPressed = false
    
    let uploadUsingURLSessionAPI = UploadUsingURLSessionAPI()
    var idCategory: Int?
    var categoryName: String?
    
    weak var coordinator: CatalogAndProductsCoordinator?
    let workWithBasket = WorkWithBasket()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catalogNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellName = UINib(nibName: "CollectionViewCellForMainVC", bundle: nil)
        collectionView.register(cellName, forCellWithReuseIdentifier: "CollectionViewCellForMainVC")
        
        guard let idCategory = idCategory, let categoryName = categoryName else {return}
        
        catalogNameLabel.text = "Категирия: " + categoryName

        authRegistrationAndWorkWithProducts.getProductByCategory(idCategory: idCategory){
            [weak self] allProductsWithCategory in
            guard let self = self else {return}
            self.allProducts = allProductsWithCategory
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        

        view.backgroundColor = .white
    }
    
    
    override func viewDidLayoutSubviews() {
        setSearchBar()
    }
    

    private func setSearchBar(){
        let mainColorForSearchBar = UIColor(red: 126/255, green: 187/255, blue: 59/255, alpha: 1)
        searchBar.setPlaceholderTextColorTo(textColor: mainColorForSearchBar, placeholderTextColor: UIColor.gray, backgroundColor: UIColor.white, leftViewColor: mainColorForSearchBar)
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
            let liftingHighOfMessage: CGFloat = 230
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



extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellForMainVC", for: indexPath) as? CollectionViewCellForMainVC else {return UICollectionViewCell()}
                
        cell.config(oneProduct: allProducts[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberCol = 2
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberCol - 1))
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberCol))
        let height = Int(Double(width)*2)
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.openProductDescriptionViewController(product: allProducts[indexPath.row])
    }
    
}
