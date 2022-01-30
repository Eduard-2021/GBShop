//
//  MainViewController.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {
 
    let convertingImageToDataFormat = ConvertingImageToDataFormat()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    var allProducts = [OneProduct]()
    let createAndLoadProductsToServer = CreateAndLoadProductsToServer()
    
    let uploadUsingURLSessionAPI = UploadUsingURLSessionAPI()
    
    weak var coordinator: MainAndProductsCoordinator?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellName = UINib(nibName: "CollectionViewCellForMainVC", bundle: nil)
        collectionView.register(cellName, forCellWithReuseIdentifier: "CollectionViewCellForMainVC")

        createAndLoadProductsToServer.upLoadProductsWithImagesToServer() {
                self.authRegistrationAndWorkWithProducts.getProductByPromotion(promotion: 1){
                    [weak self] allProductsWithCategory in
                    guard let self = self else {return}
                    self.allProducts = allProductsWithCategory
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
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


extension UISearchBar
{
    func setPlaceholderTextColorTo(textColor: UIColor, placeholderTextColor: UIColor, backgroundColor: UIColor, leftViewColor: UIColor)
    {
        self.backgroundImage = UIImage()
        if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = textColor
            textFieldInsideSearchBar.backgroundColor = backgroundColor
            if let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel {
                textFieldInsideSearchBarLabel.textColor = placeholderTextColor
            }
            if let leftView = textFieldInsideSearchBar.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = leftViewColor
            }
        }
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellForMainVC", for: indexPath) as? CollectionViewCellForMainVC
        else {return UICollectionViewCell()}
        cell.config(oneProduct: allProducts[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberCol = 2
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize()}
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

//extension UICollectionView {
//    func setItemsInRow(items: Int) {
//        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
//            let contentInset = self.contentInset
//            let itemsInRow: CGFloat = CGFloat(items);
//            let innerSpace = layout.minimumInteritemSpacing * (itemsInRow - 1.0)
//            let insetSpace = contentInset.left + contentInset.right + layout.sectionInset.left + layout.sectionInset.right
//            let width = floor((frame.width - insetSpace - innerSpace) / itemsInRow);
//            layout.itemSize = CGSize(width: width, height: width)
//        }
//    }
//}
