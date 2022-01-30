//
//  TimeOfDeliveryViewController.swift
//  GBShop
//
//  Created by Eduard on 29.01.2022.
//

import UIKit

class TimeOfDeliveryViewController: UIViewController, Storyboardable  {
    
    var coordinator: BasketCoordinator?
    var isSelected = false
    var delegate: CheckoutStep1ViewController?
    var deliveryTimeOption = 0
    
    
    @IBOutlet weak var deliveryTimeOption1ButtonOutlet: UIButton!
    @IBOutlet weak var deliveryTimeOption1OkButtonOutlet: UIButton!
    @IBOutlet weak var deliveryTimeOption2ButtonOutlet: UIButton!
    @IBOutlet weak var deliveryTimeOption2OkButtonOutlet: UIButton!
    @IBOutlet weak var okButtonOutlet: UIButton!
    
    
    
    func selectMode(okButton: UIButton, mode:UIButton,
                    defaultMessage: String = "Выбрать время доставки",
                    deliveryTimeOption: Int){
        if !isSelected {
            isSelected = true
            okButton.isHidden = false
            okButtonOutlet.isUserInteractionEnabled = true
            okButtonOutlet.backgroundColor = UIColor.newGreen
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.deliveryTimeLabel.text = textInButton
            delegate?.deliveryTimeOption = deliveryTimeOption
            self.deliveryTimeOption = deliveryTimeOption
        }
        else if self.deliveryTimeOption == deliveryTimeOption {
            isSelected = false
            okButton.isHidden = true
            okButtonOutlet.isUserInteractionEnabled = false
            okButtonOutlet.backgroundColor = UIColor.newGray
            delegate?.deliveryTimeLabel.text = defaultMessage
            delegate?.deliveryTimeOption = 0
            self.deliveryTimeOption = 0
        } else {
            okButton.isHidden = false
            guard let textInButton = mode.titleLabel?.text else {return}
            delegate?.deliveryTimeLabel.text = textInButton
            delegate?.deliveryTimeOption = deliveryTimeOption
            
            switch self.deliveryTimeOption {
            case 1:
                deliveryTimeOption1OkButtonOutlet.isHidden = true
            case 2:
                deliveryTimeOption2OkButtonOutlet.isHidden = true
            default: break
     
            }
            self.deliveryTimeOption = deliveryTimeOption
        }
    }
    
    @IBAction func deliveryTimeOption1Button(_ sender: Any) {
        selectMode(okButton: deliveryTimeOption1OkButtonOutlet, mode: deliveryTimeOption1ButtonOutlet, deliveryTimeOption: 1)
    }
    

    @IBAction func deliveryTimeOption2Button(_ sender: Any) {
        selectMode(okButton: deliveryTimeOption2OkButtonOutlet, mode: deliveryTimeOption2ButtonOutlet, deliveryTimeOption: 2)
    }


    @IBAction func okButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    
    private func configureButtons(){
        deliveryTimeOption1OkButtonOutlet.setTitle("", for: .normal)
        deliveryTimeOption2OkButtonOutlet.setTitle("", for: .normal)

        deliveryTimeOption1ButtonOutlet.setAttributedTitle(NSAttributedString(string: getDate(1)), for: .normal)
        deliveryTimeOption2ButtonOutlet.setAttributedTitle(NSAttributedString(string: getDate(2)), for: .normal)
        
        let widthButton = okButtonOutlet.frame.width
        okButtonOutlet.layer.cornerRadius = widthButton / 25
        
        switch deliveryTimeOption {
        case 1:
            selectMode(okButton: deliveryTimeOption1OkButtonOutlet, mode: deliveryTimeOption1ButtonOutlet, deliveryTimeOption: 1)
        case 2:
            selectMode(okButton: deliveryTimeOption2OkButtonOutlet, mode: deliveryTimeOption2ButtonOutlet, deliveryTimeOption: 2)
        default: break
  
        }
    }
    
    
    private func getDate(_ daysToComplete: Int) -> String{
        let timeNow = NSDate()
        let time = NSDate(timeIntervalSinceReferenceDate: timeNow.timeIntervalSinceReferenceDate + Double(daysToComplete*60*60*24))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 7200)
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate + " c 09:00 до 19:00"
    }
}

