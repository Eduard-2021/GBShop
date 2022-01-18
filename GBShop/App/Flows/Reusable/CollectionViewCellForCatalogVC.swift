//
//  CollectionViewCellForCatalogVC.swift
//  GBShop
//
//  Created by Eduard on 17.01.2022.
//

import UIKit

class CollectionViewCellForCatalogVC: UICollectionViewCell {

    @IBOutlet weak var imageCategoryUIImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(category: Category){
        imageCategoryUIImageView.image = UIImage(data: category.categoryImage)
        categoryLabel.text = category.categoryName

    }

}
