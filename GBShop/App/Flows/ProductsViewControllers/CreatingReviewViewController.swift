//
//  CreatingReviewViewController.swift
//  GBShop
//
//  Created by Eduard on 22.01.2022.
//

import UIKit

class CreatingReviewViewController: UIViewController, Storyboardable {
    
    var coordinator: DescriptionAndReviewsProtocol?
    var product: OneProduct? = nil
    var score = 5.0
    private let authAndRegistration = AuthRegistrationAndWorkWithProducts()
    
    
    @IBOutlet weak var productImageImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var noLikedLabel: UILabel!
    @IBOutlet weak var userExperienceLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var likedTextField: UITextField!
    @IBOutlet weak var noLikedtextField: UITextField!
    @IBOutlet weak var userExperienceTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addReviewsButtonOutlet: UIButton!
    
    @IBOutlet weak var scoreSlider: UISlider!
    
    @IBAction func scoreSlider(_ sender: UISlider) {
        let value = sender.value
        let valueInInt = Int(value*10)
        let valueInDouble = Double(valueInInt)
        let valueForSave = Double(valueInDouble/10)
        scoreLabel.text = String(valueForSave)
        score = valueForSave
    }
    
    @IBAction func addReviewsButton(_ sender: Any) {
        addReviewsButtonOutlet.isSelected = true

        likedTextField.delegate = self
        noLikedtextField.delegate = self
        userExperienceTextField.delegate = self
        commentsTextField.delegate = self
        
        guard
            let likedTextField =  likedTextField.text,
            let noLikedtextField = noLikedtextField.text,
            let userExperienceTextField = userExperienceTextField.text,
            let commentsTextField = commentsTextField.text,
            var product = product,
            let user = Constant.shared.user
        else {return}
        
        if  (likedTextField == "" &&
            noLikedtextField == "" &&
            userExperienceTextField == "" &&
            commentsTextField == "") ||
            (likedTextField == "Что понравилось?" &&
            noLikedtextField == "Что не понравилось?" &&
            userExperienceTextField == "Опыт использования (день, месяц и т.п.)?" &&
            commentsTextField == "Дополнительные комментарии")
        {
            unCorrectLoginPaswordOrEmptyField()
        }
        else {
            
            let newComment = NewComment(
                idProduct: product.idProduct,
                commentatorName: user.userName,
                commentDate: getDate(),
                comment: commentsTextField != "Дополнительные комментарии" ? commentsTextField :"",
                score: score,
                liked: likedTextField != "Что понравилось?" ? likedTextField : "",
                noLiked: noLikedtextField != "Что не понравилось?" ? noLikedtextField : "",
                userExperienсe: userExperienceTextField != "Опыт использования (день, месяц и т.п.)?" ? userExperienceTextField : "")
            
            
            
            authAndRegistration.createNewComment(newComment: newComment) { isCorrect in
                if isCorrect {
                    self.authAndRegistration.getOneProduct(idProduct: product.idProduct) { productWithNewComment in
                        guard let productWithNewComment = productWithNewComment else {return}
                        
                        DispatchQueue.main.async {
                            guard let allVC = self.navigationController?.viewControllers else {return}
                            for (index, vc) in allVC.enumerated() {
                                if let productReviewsViewController = vc as? ProductReviewsViewController {
                                    productReviewsViewController.product = productWithNewComment
                                    productReviewsViewController.comments = productWithNewComment.commentList
                                    productReviewsViewController.configureTotalScores(comments: productWithNewComment.commentList)
                                    productReviewsViewController.tableView.reloadData()
                                    if (index+2) != allVC.count {
                                        for indexVCForDelete in ((index + 1) ... (allVC.count - 2)).reversed() {
                                            self.navigationController?.viewControllers.remove(at: indexVCForDelete)
                                        }
                                    }
                                }
                            }
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
        navigationController?.navigationBar.topItem?.title = ""
        
        setViewsDelegates()
        showInformationAboutProduct()

    }
    
    private func showInformationAboutProduct(){
        guard let product = product else {return}
        productImageImageView.image = UIImage(data: product.productImage)
        productNameLabel.text = product.productName
    }
    
    private func getDate() -> String{
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 7200)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        return "\(formatteddate)"
        
    }
    
    private func setViewsDelegates(){
        
        likedTextField.delegate = self
        noLikedtextField.delegate = self
        userExperienceTextField.delegate = self
        commentsTextField.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

}


extension CreatingReviewViewController: UnCorrectLoginPaswordOrEmptyFieldProtocol {
    func unCorrectLoginPaswordOrEmptyField() {
        addReviewsButtonOutlet.isSelected = false
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Не заполнены все поля",
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok", style: .default, handler:
                                        { _ in})
        alertController.addAction(buttonOk)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

extension CreatingReviewViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
            case likedTextField:
                likedLabel.isHidden = false
            case noLikedtextField:
                noLikedLabel.isHidden = false
            case userExperienceTextField:
                userExperienceLabel.isHidden = false
            case commentsTextField:
                commentsLabel.isHidden = false
            default:
                break
        }
    }
}
