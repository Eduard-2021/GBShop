//
//  ProductReviewsController.swift
//  GBShop
//
//  Created by Eduard on 19.01.2022.
//

import UIKit

class ProductReviewsViewController: UIViewController, Storyboardable  {
    
    var comments = [OneComment]()
    
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    weak var coordinator: CatalogAndProductsCoordinator?
    var product: OneProduct? = nil
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func aboutProductButton(_ sender: Any) {
        guard let product = product else {return}
        coordinator?.openProductDescriptionViewController(product: product)
    }
    
    @IBAction func buyButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {return}
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellName = UINib(nibName: "TableViewCellForProductReviewsVC", bundle: nil)
        tableView.register(cellName, forCellReuseIdentifier: "TableViewCellForProductReviewsVC")
        
        view.backgroundColor = .white


    }
}

extension ProductReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
}
