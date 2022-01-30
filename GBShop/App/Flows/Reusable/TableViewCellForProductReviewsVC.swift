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
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var choiceScoreLabel: UILabel!
    @IBOutlet weak var handImageView: UIImageView!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var didNotLikeLabel: UILabel!
    @IBOutlet weak var userExperienceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(comment: OneComment){
        userNameLabel.text = comment.commentatorName
        dateLabel.text = comment.commentDate
        scoreslabel.text = String(comment.score)
        var sroreForDefinitionStars = 0.0
        let stars = [star1, star2, star3, star4, star5]
        while sroreForDefinitionStars < comment.score {
            sroreForDefinitionStars += 0.5
            if Int(sroreForDefinitionStars-0.5) == Int(sroreForDefinitionStars) {
                stars[Int(sroreForDefinitionStars)]?.image = UIImage(systemName: "star.leadinghalf.filled")
                stars[Int(sroreForDefinitionStars)]?.tintColor = .systemOrange
            }
            else {
                stars[Int(sroreForDefinitionStars-0.5)]?.image = UIImage(systemName: "star.fill")
                stars[Int(sroreForDefinitionStars-0.5)]?.tintColor = .systemOrange
            }
        }
        switch comment.score {
        case 3..<4.6 :
            choiceScoreLabel.text = "хороший выбор"
            recommendationLabel.text = "Рекомендую"
        case 4.6...6 :
            choiceScoreLabel.text = "отличный выбор"
            recommendationLabel.text = "Рекомендую"
        default:
            handImageView.image = UIImage(systemName: "hand.thumbsdown.fill")
            handImageView.tintColor = .systemGray
            choiceScoreLabel.text = "плохой выбор"
            recommendationLabel.text = "Не рекомендую"
            recommendationLabel.textColor = .systemGray
        }
        
        likedLabel.text = comment.liked
        didNotLikeLabel.text = comment.noLiked
        userExperienceLabel.text = comment.userExperienсe
        reviewLabel.text = comment.comment
    }
}
