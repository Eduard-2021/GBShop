//
//  LoginViaPhoneNumberViewController.swift
//  GBShop
//
//  Created by Eduard on 27.11.2021.
//

import UIKit

class LoginViaPhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberFromTextField: UITextField!
    @IBOutlet weak var passwordFromTextField: UITextField!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var codeCountryLabel: UILabel!
    @IBOutlet weak var selectCountryPickerView: UIPickerView!
    
    
    @IBAction func turnToEmailAuth(_ sender: Any) {
    }
    
    @IBAction func phoneNumberEntered(_ sender: Any) {
    }
    
    @IBAction func passwordEntered(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        
        
    }
    
    @IBAction func changeCountryButtonPressed(_ sender: Any) {
        selectCountryPickerView.isHidden = false
        guard let currentCounty = Constant.shared.countryDialingCodes.firstIndex(where: {$0.0.contains(codeCountryLabel.text ?? "")}) else {return}
        selectCountryPickerView.selectRow(currentCounty, inComponent: 0, animated: false)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
    private let homeworkCallFromOneToSix = HomeworkCallFromOneToSix()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectCountryPickerView.dataSource = self
        selectCountryPickerView.delegate = self
        
//        homeworkCallFromOneToSix.callAll()
    }
}


extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constant.shared.countryDialingCodes.count
    }
}


extension ViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Constant.shared.countryDialingCodes[row].0
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return myTitle
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let codeInSubSequense = Constant.shared.countryDialingCodes[row].0.split(separator: " ").last else {return}
        let fileName = Constant.shared.countryDialingCodes[row].1
        let codeInString = String(codeInSubSequense)
        
        flagImage.image = UIImage(named: fileName)
        codeCountryLabel.text = codeInString
        
        selectCountryPickerView.isHidden = true
    }
}
