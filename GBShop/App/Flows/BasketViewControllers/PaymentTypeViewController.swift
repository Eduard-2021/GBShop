//
//  PaymentTypeViewController.swift
//  GBShop
//
//  Created by Eduard on 29.01.2022.
//

import UIKit

class PaymentTypeViewController: UIViewController, Storyboardable {

    var coordinator: BasketCoordinator?
    var isSelected = false
    var delegate: CheckoutStep1ViewController?
    var paymentMethod = 0
    var account: Int?
    
    @IBOutlet weak var paymentFromDepositAccountButtonOutlet: UIButton!
    @IBOutlet weak var paymentFromDepositAccountOkButtonOutlet: UIButton!
    @IBOutlet weak var cashPaymentButtonOutlet: UIButton!
    @IBOutlet weak var cashPaymentOkButtonOutlet: UIButton!
    @IBOutlet weak var cashlessPaymentButtonOutlet: UIButton!
    @IBOutlet weak var cashlessPaymentOkButtonOutlet: UIButton!
    @IBOutlet weak var cardPaymentButtonOutlet: UIButton!
    @IBOutlet weak var cardPaymentOkButtonOutlet: UIButton!
    @IBOutlet weak var onlinePaymentButtonOutlet: UIButton!
    @IBOutlet weak var onlinePaymentOkButtonOutlet: UIButton!
    @IBOutlet weak var okButtonOutlet: UIButton!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBAction func paymentFromDepositAccountButton(_ sender: Any) {
        selectMode(okButton:paymentFromDepositAccountOkButtonOutlet,
                   mode: paymentFromDepositAccountButtonOutlet,
                   paymentMethod: 1)
    }
    
    func selectMode(okButton: UIButton, mode:UIButton, defaultMessage: String = "Выбрать способ оплаты", paymentMethod: Int){
        if !isSelected {
            isSelected = true
            okButton.isHidden = false
            okButtonOutlet.isUserInteractionEnabled = true
            okButtonOutlet.backgroundColor = UIColor.newGreen
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.paymentMethodLabel.text = textInButton
            delegate?.paymentMethod = paymentMethod
            self.paymentMethod = paymentMethod
        }
        else if self.paymentMethod == paymentMethod {
            isSelected = false
            okButton.isHidden = true
            okButtonOutlet.isUserInteractionEnabled = false
            okButtonOutlet.backgroundColor = UIColor.newGray
            delegate?.paymentMethodLabel.text = defaultMessage
            delegate?.paymentMethod = 0
            self.paymentMethod = 0
        } else {
            okButton.isHidden = false
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.paymentMethodLabel.text = textInButton
            delegate?.paymentMethod = paymentMethod
            
            switch self.paymentMethod {
            case 1:
                paymentFromDepositAccountOkButtonOutlet.isHidden = true
            case 2:
                cashPaymentOkButtonOutlet.isHidden = true
            case 3:
                cashlessPaymentOkButtonOutlet.isHidden = true
            case 4:
                cardPaymentOkButtonOutlet.isHidden = true
            case 5:
                onlinePaymentOkButtonOutlet.isHidden = true
            default: break
     
            }
            self.paymentMethod  = paymentMethod
        }
    }
    
    @IBAction func cashPaymentButton(_ sender: Any) {
        selectMode(okButton: cashPaymentOkButtonOutlet,
                   mode: cashPaymentButtonOutlet,
                   paymentMethod: 2)
    }

    @IBAction func cashlessPaymentButton(_ sender: Any) {
        selectMode(okButton: cashlessPaymentOkButtonOutlet,
                   mode: cashlessPaymentButtonOutlet,
                   paymentMethod: 3)
    }
    
    @IBAction func cardPaymentButton(_ sender: Any) {
        selectMode(okButton: cardPaymentOkButtonOutlet,
                   mode: cardPaymentButtonOutlet,
                   paymentMethod: 4)
    }
    
    @IBAction func onlinePaymentButton(_ sender: Any) {
        selectMode(okButton: onlinePaymentOkButtonOutlet,
                   mode: onlinePaymentButtonOutlet,
                   paymentMethod: 5)
    }

    @IBAction func okButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let account = account else {return}
        accountLabel.text = String(account) + " ₴"
        configureButtons()
    }
    
    
    private func configureButtons(){
        paymentFromDepositAccountOkButtonOutlet.setTitle("", for: .normal)
        cashPaymentOkButtonOutlet.setTitle("", for: .normal)
        cashlessPaymentOkButtonOutlet.setTitle("", for: .normal)
        cardPaymentOkButtonOutlet.setTitle("", for: .normal)
        onlinePaymentOkButtonOutlet.setTitle("", for: .normal)
        
        let widthButton = okButtonOutlet.frame.width
        okButtonOutlet.layer.cornerRadius = widthButton / 25
        
        switch paymentMethod {
        case 1:
            selectMode(okButton:paymentFromDepositAccountOkButtonOutlet,
                       mode: paymentFromDepositAccountButtonOutlet,
                       paymentMethod: 1)
        case 2:
            selectMode(okButton: cashPaymentOkButtonOutlet,
                       mode: cashPaymentButtonOutlet,
                       paymentMethod: 2)
        case 3:
            selectMode(okButton: cashlessPaymentOkButtonOutlet,
                       mode: cashlessPaymentButtonOutlet,
                       paymentMethod: 3)
        case 4:
            selectMode(okButton: cardPaymentOkButtonOutlet,
                       mode: cardPaymentButtonOutlet,
                       paymentMethod: 4)
        case 5:
            selectMode(okButton: onlinePaymentOkButtonOutlet,
                       mode: onlinePaymentButtonOutlet,
                       paymentMethod: 5)
        default: break
  
        }
    }
}
