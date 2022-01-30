//
//  OrderNumberPageViewController.swift
//  GBShop
//
//  Created by Eduard on 29.01.2022.
//

import UIKit

class OrderNumberPageViewController: UIViewController, Storyboardable  {
    
    var coordinator: BasketCoordinator?
    weak var tabBarVC: CreateTabBarController?
    var deliveryAndPaymentMethodsTimeAndSumm: [String]?
    
    var isDetailsLabelHidden = true
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var deliveryMethodlabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var balanceOfDepositAccountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNumberOrEmailLabel: UILabel!
    @IBOutlet weak var orderSummLabel: UILabel!
    @IBOutlet weak var deliverySummLabel: UILabel!
    @IBOutlet weak var totalSummLabel: UILabel!
    
    @IBOutlet weak var titleDateAndTimeLabel: UILabel!
    @IBOutlet weak var titleDeliveryMethodlabel: UILabel!
    @IBOutlet weak var titlePaymentMethodLabel: UILabel!
    @IBOutlet weak var titleDeliveryTimeLabel: UILabel!
    @IBOutlet weak var titleBalanceOfDepositAccountLabel: UILabel!
    @IBOutlet weak var titleUserNameLabel: UILabel!
    @IBOutlet weak var titlePhoneNumberOrEmailLabel: UILabel!
    
    private func showAllDetailsLabel(){
        dateAndTimeLabel.isHidden = false
        deliveryMethodlabel.isHidden = false
        paymentMethodLabel.isHidden = false
        deliveryTimeLabel.isHidden = false
        balanceOfDepositAccountLabel.isHidden = false
        userNameLabel.isHidden = false
        phoneNumberOrEmailLabel.isHidden = false
        
        titleDateAndTimeLabel.isHidden = false
        titleDeliveryMethodlabel.isHidden = false
        titlePaymentMethodLabel.isHidden = false
        titleDeliveryTimeLabel.isHidden = false
        titleBalanceOfDepositAccountLabel.isHidden = false
        titleUserNameLabel.isHidden = false
        titlePhoneNumberOrEmailLabel.isHidden = false
    }
    
    private func hiddenAllDetailsLabel(){
        dateAndTimeLabel.isHidden = true
        deliveryMethodlabel.isHidden = true
        paymentMethodLabel.isHidden = true
        deliveryTimeLabel.isHidden = true
        balanceOfDepositAccountLabel.isHidden = true
        userNameLabel.isHidden = true
        phoneNumberOrEmailLabel.isHidden = true
        
        titleDateAndTimeLabel.isHidden = true
        titleDeliveryMethodlabel.isHidden = true
        titlePaymentMethodLabel.isHidden = true
        titleDeliveryTimeLabel.isHidden = true
        titleBalanceOfDepositAccountLabel.isHidden = true
        titleUserNameLabel.isHidden = true
        titlePhoneNumberOrEmailLabel.isHidden = true
    }
    
    
    @IBOutlet weak var orderDetailsButtonOutlet: UIButton!
    @IBOutlet weak var onMainButtonOutlet: UIButton!
    
    @IBOutlet weak var stackOfOrderDetailsOutlet: UIStackView!
    
    @IBAction func orderDetailsButton(_ sender: Any) {
        if isDetailsLabelHidden {
//            stackOfOrderDetailsOutlet.isHidden = false
            stackOfOrderDetailsOutlet.spacing = 17
            showAllDetailsLabel()
            isDetailsLabelHidden = false
            orderDetailsButtonOutlet.setImage(UIImage(systemName: "arrowtriangle.forward"), for: .normal)
        }
        else {
//            stackOfOrderDetailsOutlet.isHidden = true
            stackOfOrderDetailsOutlet.spacing = 0
            hiddenAllDetailsLabel()
            isDetailsLabelHidden = true
            orderDetailsButtonOutlet.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        }
    }
    
    @IBAction func onMainButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
        tabBarVC?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureLabel()
        stackOfOrderDetailsOutlet.spacing = 0
        hiddenAllDetailsLabel()
    }
    
    private func configureButtons(){
        orderDetailsButtonOutlet.setTitle("", for: .normal)
        
        let widthButton = onMainButtonOutlet.frame.width
        onMainButtonOutlet.layer.cornerRadius = widthButton / 20
    }
    
    private func configureLabel(){
        
        guard let user = Constant.shared.user else {return}
        userNameLabel.text = user.userName
        phoneNumberOrEmailLabel.text = user.phoneNumber != "" ? user.phoneNumber : user.email
        
        guard let deliveryAndPaymentMethodsTimeAndSumm = deliveryAndPaymentMethodsTimeAndSumm else {return}
        
        orderNumberLabel.text = "\(Int.random(in: 11000..<12000))"
        dateAndTimeLabel.text = getCurrentDateAndTime()
        deliveryMethodlabel.text = deliveryAndPaymentMethodsTimeAndSumm[0]
        paymentMethodLabel.text = deliveryAndPaymentMethodsTimeAndSumm[1]
        deliveryTimeLabel.text = deliveryAndPaymentMethodsTimeAndSumm[2]
        orderSummLabel.text = deliveryAndPaymentMethodsTimeAndSumm[3]
        deliverySummLabel.text = deliveryAndPaymentMethodsTimeAndSumm[4]
        totalSummLabel.text = deliveryAndPaymentMethodsTimeAndSumm[5]
        balanceOfDepositAccountLabel.text = deliveryAndPaymentMethodsTimeAndSumm[6]
    }
    
    private func getCurrentDateAndTime() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 7200)
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate
        
    }
}
