//
//  CheckoutStep1ViewController.swift
//  GBShop
//
//  Created by Eduard on 27.01.2022.
//

import UIKit

class CheckoutStep1ViewController: UIViewController, Storyboardable  {
    
    var coordinator: BasketCoordinator?
    weak var tabBarVC: CreateTabBarController?
    var count = 0
    
    let workWithBasket = WorkWithBasket()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    
    
    var deliveryMethod = (0,0)
    var paymentMethod = 0
    var account = Constant.shared.account
    var deliveryTimeOption = 0
    var totalPriceWithDelivery = 0
    
    var deliveryAndPaymentMethodsTimeAndSumm: [String] {
        guard let deliveryMethod = deliveryMethodLabel.text,
              let paymentMethod = paymentMethodLabel.text,
              let deliveryTime = deliveryTimeLabel.text,
              let oderSumm = oderSummLabel.text,
              let deliverySumm = deliverySummLabel.text,
              let totalSumm = totalSummLabel.text
        else {return []}
              
        return [deliveryMethod, paymentMethod, deliveryTime, oderSumm, deliverySumm, totalSumm, "\(account)"]
    }

    
    @IBAction func editBasketButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editContactButton(_ sender: Any) {
        guard let tabBarVC = tabBarVC else {return}
        tabBarVC.selectedIndex = 2
    }
    
    @IBAction func deliveryMethodButton(_ sender: Any) {
        coordinator?.openTypeOfDeliveryViewController(checkVC: self, deliveryMethod: deliveryMethod)
    }
    
    @IBAction func paymentMethodButton(_ sender: Any) {
        coordinator?.openPaymentTypeViewController(checkVC: self, paymentMethod: paymentMethod, account: account)
    }
    
    @IBAction func deliveryTimeButton(_ sender: Any) {
        coordinator?.openTimeOfDeliveryViewController(checkVC: self, deliveryTimeOption: deliveryTimeOption)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextStepButton(_ sender: Any) {
        if totalPriceWithDelivery  > account {
            notEnoughMoney()
            return
        }
        if deliveryMethod != (0,0) && (paymentMethod != 0) && (deliveryTimeOption != 0) {
            //Constant.shared.selectedProducts = [] //работа через Singlton
            
            workWithBasket.payBasket(amountFundsOnAccount: account, costOfDelivery: deliveryMethod.1){response in
                if response.result == 0 {
                    self.notEnoughMoney()
                    return
                } else {
                    self.account = response.amountFundsOnAccount
                    Constant.shared.account = response.amountFundsOnAccount
                    DispatchQueue.main.async {
                        self.coordinator?.openOrderNumberPageViewController(deliveryAndPaymentMethodsTimeAndSumm:self.deliveryAndPaymentMethodsTimeAndSumm)
                        print("\n\nЗаказ успешно оплачен!")
                    }
                }
            }
        }
        else {
            var whatNeedToFill = [String]()
            if deliveryMethod == (0,0) {whatNeedToFill.append("Способ доставки")}
            if paymentMethod == 0 {whatNeedToFill.append("Способ оплаты")}
            if deliveryTimeOption == 0 {whatNeedToFill.append("Время доставки")}
            needToFill(whatNeedToFill: whatNeedToFill)
        }
    }
    
    @IBOutlet weak var editBasketButtonOutlet: UIButton!
    @IBOutlet weak var deliveryMethodButtonOutlet: UIButton!
    @IBOutlet weak var paymentMethodButtonOutlet: UIButton!
    @IBOutlet weak var deliveryTimeButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var nextStepButtonOutlet: UIButton!
    

    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var deliveryMethodLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var oderSummLabel: UILabel!
    @IBOutlet weak var deliverySummLabel: UILabel!
    @IBOutlet weak var totalSummLabel: UILabel!
    
    private func configureButtons(){
        deliveryMethodButtonOutlet.setTitle("", for: .normal)
        paymentMethodButtonOutlet.setTitle("", for: .normal)
        deliveryTimeButtonOutlet.setTitle("", for: .normal)
        
        let widthButton = editBasketButtonOutlet.frame.width
        editBasketButtonOutlet.layer.cornerRadius = widthButton / 15
        backButtonOutlet.layer.cornerRadius = widthButton / 15
        nextStepButtonOutlet.layer.cornerRadius = widthButton / 15
    }
    
    private func configureLabel(){
        
        //let selectedProducts = Constant.shared.selectedProducts // работа с корзиной через Singlton
        
        var selectedProducts = [(OneProduct, Int)]()
        
        workWithBasket.getBasket {basketFromServer in
            for oneProductInBasket in basketFromServer.basket {
                self.authRegistrationAndWorkWithProducts.getOneProduct(idProduct: oneProductInBasket.idProduct) {oneProduct in
                    guard let oneProduct = oneProduct else {return}
                    selectedProducts.append((oneProduct,oneProductInBasket.productsNumber ))
                    
                    var totalPrice = 0
                    for oneProduct in selectedProducts {
                        totalPrice += oneProduct.0.productPrice * oneProduct.1
                    }
                    
                    DispatchQueue.main.async {
                        guard let user = Constant.shared.user else {return}
                        self.contactLabel.text = user.userName + ", " + user.phoneNumber + " На счету: \(self.account)₴"
                        
                        self.totalPriceWithDelivery = totalPrice + self.deliveryMethod.1
                        
                        self.oderSummLabel.text = String(totalPrice)
                        self.deliverySummLabel.text = String(self.deliveryMethod.1)
                        self.totalSummLabel.text = String(self.totalPriceWithDelivery)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButtons()
        configureLabel()
    }
}


extension CheckoutStep1ViewController {
    
    func needToFill(whatNeedToFill: [String]) {
        var message: String
        if whatNeedToFill.count > 1 {
            var whatNeedToFill = whatNeedToFill.reduce("", {$0 + ", " + $1})
            whatNeedToFill.removeFirst()
            message = "Для продолжения оформления необходимо заполнить поля: " + whatNeedToFill
            
        } else {
            message = "Для продолжения оформления необходимо заполнить поле: " + whatNeedToFill[0]
        }
        let alertController = UIAlertController(title: message, message: nil,
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok",
                                     style: .default)
        alertController.addAction(buttonOk)
        present(alertController, animated: true)
    }
    
    func notEnoughMoney() {
        let alertController = UIAlertController(title: "У вас недостаточно средств!", message: nil,
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok",
                                     style: .default)
        alertController.addAction(buttonOk)
        present(alertController, animated: true)

    }
    
    
}
