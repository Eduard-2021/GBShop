//
//  TableViewCellForProductReviewsVC.swift
//  GBShop
//
//  Created by Eduard on 20.01.2022.
//

import UIKit

class TableViewCellForProductReviewsVC: UITableViewCell {

   
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreslabel: UILabel!
    @IBOutlet weak var star1Label: UILabel!
    @IBOutlet weak var star2Label: UILabel!
    @IBOutlet weak var star3Label: UILabel!
    @IBOutlet weak var star4Label: UILabel!
    @IBOutlet weak var star5Label: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var didNotLikeLabel: UILabel!
    @IBOutlet weak var userExperienceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(comment: OneComment){
        
    }
    
}
