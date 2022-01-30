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
    var coordinator: DescriptionAndReviewsProtocol?
    var product: OneProduct? = nil
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basedLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var handImageView: UIImageView!
    @IBOutlet weak var recomendationLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBAction func writeReviewButton(_ sender: Any) {
        if Constant.shared.user != nil {
            guard let product = product else {return}
            coordinator?.openCreatingReviewViewController(product: product)
        } else {
            coordinator?.openLoginViaPhoneNumberViewController(isCreatingReview: true)
        }
    }
    
    @IBAction func aboutProductButton(_ sender: Any) {
        guard let product = product else {return}
        coordinator?.openProductDescriptionViewController(product: product)
    }
    
    @IBAction func buyButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {return}
        comments = product.commentList
        tableView.reloadData()
        configureTotalScores(comments: product.commentList)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellName = UINib(nibName: "TableViewCellForProductReviewsVC", bundle: nil)
        tableView.register(cellName, forCellReuseIdentifier: "TableViewCellForProductReviewsVC")
        
        view.backgroundColor = .white
    }
    
    func switchToCreatingReviewViewController() {
        guard let product = product else {return}
        coordinator?.openCreatingReviewViewController(product: product)
    }
    
    func configureTotalScores(comments: [OneComment]){
        
        basedLabel.text = "на основании \(comments.count) отзыва/ов"
        let averageRating = (comments.reduce(0.0, {$0 + $1.score}))/Double(comments.count)
        scoresLabel.text = String(format:"%.1f", averageRating)
 
        var sroreForDefinitionStars = 0.0
        let stars = [star1, star2, star3, star4, star5]
        while sroreForDefinitionStars < averageRating {
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
        switch averageRating {
        case 3...6 :
            recomendationLabel.text = "\(comments.count) рекомендуют этот товар"
        default:
            handImageView.image = UIImage(systemName: "hand.thumbsdown.fill")
            handImageView.tintColor = .systemGray
            recomendationLabel.text = "\(comments.count) не рекомендуют этот товар"
            recomendationLabel.textColor = .systemGray
        }
    }
}


extension ProductReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellForProductReviewsVC", for: indexPath) as? TableViewCellForProductReviewsVC else {return UITableViewCell()}
        cell.config(comment: comments[indexPath.row])
        
        return cell
    }
}
