//
//  TypeOfDeliveryViewController.swift
//  GBShop
//
//  Created by Eduard on 29.01.2022.
//

import UIKit

class TypeOfDeliveryViewController: UIViewController, Storyboardable  {
    
    var coordinator: BasketCoordinator?
    var isSelected = false
    var delegate: CheckoutStep1ViewController?
    var deliveryMethod = (0, 0)
    
    @IBOutlet weak var pickupButtonOutlet: UIButton!
    @IBOutlet weak var pickupOkButtonOutlet: UIButton!
    @IBOutlet weak var scheduledDeliveryButtonOutlet: UIButton!
    @IBOutlet weak var scheduledDeliveryOkButtonOutlet: UIButton!
    @IBOutlet weak var scheduledDeliveryOutTownButtonOutlet: UIButton!
    @IBOutlet weak var scheduledDeliveryOutTownСonditionButtonOutlet: UIButton!
    @IBOutlet weak var scheduledDeliveryOutTownOkButtonOutlet: UIButton!
    @IBOutlet weak var okButtonOutlet: UIButton!
    
    
    
    func selectMode(okButton: UIButton, mode:UIButton,  defaultMessage: String = "Выбрать способ доставки", deliveryMethod: (Int, Int)){
        if !isSelected {
            isSelected = true
            okButton.isHidden = false
            okButtonOutlet.isUserInteractionEnabled = true
            okButtonOutlet.backgroundColor = UIColor.newGreen
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.deliveryMethodLabel.text = textInButton
            delegate?.deliveryMethod = deliveryMethod
            self.deliveryMethod = deliveryMethod
        }
        else if self.deliveryMethod == deliveryMethod {
            isSelected = false
            okButton.isHidden = true
            okButtonOutlet.isUserInteractionEnabled = false
            okButtonOutlet.backgroundColor = UIColor.newGray
            delegate?.deliveryMethodLabel.text = defaultMessage
            delegate?.deliveryMethod = (0,0)
            self.deliveryMethod = (0,0)
        } else {
            okButton.isHidden = false
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.deliveryMethodLabel.text = textInButton
            delegate?.deliveryMethod = deliveryMethod
            
            switch self.deliveryMethod.0 {
            case 1:
                pickupOkButtonOutlet.isHidden = true
            case 2:
                scheduledDeliveryOkButtonOutlet.isHidden = true
            case 3:
                scheduledDeliveryOutTownOkButtonOutlet.isHidden = true
            default: break
     
            }
            self.deliveryMethod = deliveryMethod
        }
    }
    
    @IBAction func pickupButton(_ sender: Any) {
        selectMode(okButton: pickupOkButtonOutlet, mode: pickupButtonOutlet, deliveryMethod: (1, 0))
    }
    

    @IBAction func scheduledDeliveryButton(_ sender: Any) {
        selectMode(okButton: scheduledDeliveryOkButtonOutlet,
                   mode: scheduledDeliveryButtonOutlet,
                   deliveryMethod: (2, 65))
    }

    @IBAction func scheduledDeliveryOutTownButton(_ sender: Any) {
        selectMode(okButton: scheduledDeliveryOutTownOkButtonOutlet,
                   mode: scheduledDeliveryOutTownButtonOutlet,
                   deliveryMethod: (3, 180))
    }

    @IBAction func okButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    
    private func configureButtons(){
        pickupOkButtonOutlet.setTitle("", for: .normal)
        scheduledDeliveryOkButtonOutlet.setTitle("", for: .normal)
        scheduledDeliveryOutTownOkButtonOutlet.setTitle("", for: .normal)
        
        let widthButton = okButtonOutlet.frame.width
        okButtonOutlet.layer.cornerRadius = widthButton / 25
        
        switch deliveryMethod.0 {
        case 1:
            selectMode(okButton: pickupOkButtonOutlet,
                       mode: pickupButtonOutlet,
                       deliveryMethod: (1, 0))
        case 2:
            selectMode(okButton: scheduledDeliveryOkButtonOutlet,
                       mode: scheduledDeliveryButtonOutlet,
                       deliveryMethod: (2, 65))
        case 3:
            selectMode(okButton: scheduledDeliveryOutTownOkButtonOutlet,
                       mode: scheduledDeliveryOutTownButtonOutlet,
                       deliveryMethod: (3, 180))
        default: break
  
        }
    }
}

extension UIColor{
    static let newGreen = UIColor(red: 126/255, green: 186/255, blue: 58/255, alpha: 1)
    static let newGray = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
}
