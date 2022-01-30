//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class CatalogViewController: UIViewController, Storyboardable {
    let createAndLoadCategoriesToServer = CreateAndLoadCategoriesToServer()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    
    weak var coordinator: CatalogAndProductsCoordinator?
    weak var tabBarVC: CreateTabBarController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catalogTitleLabel: UILabel!
    
    var allCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellName = UINib(nibName: "CollectionViewCellForCatalogVC", bundle: nil)
        collectionView.register(cellName, forCellWithReuseIdentifier: "CollectionViewCellForCatalogVC")
        
        view.backgroundColor = .white
        
        uploadCategories()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidLayoutSubviews() {
        setSearchBar()
    }
    
    func uploadCategories(){
        createAndLoadCategoriesToServer.upLoadCategoriesWithImagesToServer {
            self.authRegistrationAndWorkWithProducts.getAllCategories{
                (categories) in
                self.allCategories = categories
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    

    private func setSearchBar(){
        let mainColorForSearchBar = UIColor(red: 126/255, green: 187/255, blue: 59/255, alpha: 1)
        searchBar.setPlaceholderTextColorTo(textColor: mainColorForSearchBar, placeholderTextColor: UIColor.gray, backgroundColor: UIColor.white, leftViewColor: mainColorForSearchBar)
    }
        
        
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellForCatalogVC", for: indexPath) as? CollectionViewCellForCatalogVC else {return UICollectionViewCell()}
        cell.config(category: allCategories[indexPath.row])
        
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
        let height = Int(Double(width)*1.5)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.openProductsViewController(idCategory: allCategories[indexPath.row].idCategory, categoryName: allCategories[indexPath.row].categoryName)
    }
    
}





