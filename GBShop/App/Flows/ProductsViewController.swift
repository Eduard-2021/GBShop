//
//  ProductsViewController.swift
//  GBShop
//
//  Created by Eduard on 18.01.2022.
//

import UIKit

class ProductsViewController: UIViewController, Storyboardable {
    
    let convertingImageToDataFormat = ConvertingImageToDataFormat()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    var allProducts = [OneProduct]()
    let createAndLoadProductsToServer = CreateAndLoadProductsToServer()
    
    let uploadUsingURLSessionAPI = UploadUsingURLSessionAPI()
    var idCategory: Int?
    var categoryName: String?
    
    weak var coordinator: CatalogAndProductsCoordinator?
    
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
}



extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellForMainVC", for: indexPath) as! CollectionViewCellForMainVC
        cell.config(oneProduct: allProducts[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberCol = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberCol - 1))
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberCol))
        let height = Int(Double(width)*2)
        return CGSize(width: width, height: height)
    }
    
}
