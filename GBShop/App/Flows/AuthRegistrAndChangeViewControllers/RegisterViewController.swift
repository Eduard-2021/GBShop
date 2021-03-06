//
//  RegisterViewController.swift
//  GBShop
//
//  Created by Eduard on 03.01.2022.
//

import UIKit

class RegisterViewController: UIViewController, Storyboardable {
    
    weak var coordinator: AuthAndRegisterCoordinator?
    weak var tabBarVC: CreateTabBarController?
    
    private let homeworkCallFromOneToSix = HomeworkCallFromOneToSix()
    private let authAndRegistration = AuthRegistrationAndWorkWithProducts()
    private var selectRow = 1
    
    @IBOutlet weak var phoneNumberFromTextField: UITextField!
    @IBOutlet weak var emailFromTextField: UITextField!
    @IBOutlet weak var passwordFromTextField: UITextField!
    @IBOutlet weak var userNameFromTextField: UITextField!
    @IBOutlet weak var genderFromTextField: UITextField!
    @IBOutlet weak var cardNumberFromTextField: UITextField!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var codeCountryLabel: UILabel!
    @IBOutlet weak var selectCountryPickerView: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outletRegisterButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    
    
    
    @IBAction func registrButtonPressed(_ sender: Any) {
        outletRegisterButton.isSelected = true
        guard
            let phoneNumberFromTextField = phoneNumberFromTextField.text,
            let emailFromTextField = emailFromTextField.text,
            let passwordFromTextField = passwordFromTextField.text,
            let userNameFromTextField = userNameFromTextField.text,
            let genderFromTextField = genderFromTextField.text,
            let cardNumberFromTextField = cardNumberFromTextField.text
        else {return}
        
        if phoneNumberFromTextField == "" ||
            emailFromTextField == "" ||
            passwordFromTextField == "" ||
            userNameFromTextField == "" ||
            genderFromTextField == "" ||
            cardNumberFromTextField == "" ||
            phoneNumberFromTextField == "?????? ?????????? ????????????????" ||
            emailFromTextField == "?????? e-mail" ||
            passwordFromTextField == "????????????" ||
            userNameFromTextField == "???????? ??????" ||
            genderFromTextField == "?????? ??????: ??/??" ||
            cardNumberFromTextField == "?????????? ?????????? ?????????????????? ??????????"
        {
            unCorrectLoginPaswordOrEmptyField()
        }
        else {
            Constant.shared.numberOfUsers += 1
            let countryCode = Constant.shared.countryDialingCodes[selectRow].1
            
            let newUser = NewUser(
            idUser: Constant.shared.numberOfUsers,
            userName: userNameFromTextField,
            password: passwordFromTextField,
            email: emailFromTextField,
            phoneNumber: countryCode + " " + phoneNumberFromTextField,
            gender: genderFromTextField,
            creditCard: cardNumberFromTextField,
            bio: "")
            
            Constant.shared.user = newUser
            
            authAndRegistration.register(newUser: newUser) { isCorrect in
                if isCorrect {
                    self.tabBarVC?.authAndRegisterCompleted()
                    let ttt = 0//?????????????? ???? ?????????????????? ??????????
                }
            }
        }
    }
    
    @IBAction func changeCountryButtonPressed(_ sender: Any) {
        selectCountryPickerView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberOfUsers()

        selectCountryPickerView.selectRow(1, inComponent: 0, animated: false)
        authAndRegistration.loginAndRegisterViewControllerDelegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
        navigationController?.navigationBar.topItem?.title = ""
        
        setViewsDelegates()

    }
    
    private func setViewsDelegates(){
        selectCountryPickerView.dataSource = self
        selectCountryPickerView.delegate = self
        
        userNameFromTextField.delegate = self
        passwordFromTextField.delegate = self
        emailFromTextField.delegate = self
        phoneNumberFromTextField.delegate = self
        genderFromTextField.delegate = self
        cardNumberFromTextField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        // ?????????????????????????? ???? ?????? ??????????????????????: ???????? ???????????????? ?????? ?????????????????? ????????????????????
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // ???????????? ??? ?????????? ?????? ??????????????????
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
    // ???????????????? ???????????? ????????????????????
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // ?????????????????? ???????????? ?????????? UIScrollView, ???????????? ?????????????? ????????????????????
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    //?????????? ???????????????????? ???????????????????
    @objc func keyboardWillBeHidden(notification: Notification) {
        // ?????????????????????????? ???????????? ?????????? UIScrollView, ???????????? 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    private func fetchNumberOfUsers(){
        authAndRegistration.numberOfUsers{result in
            Constant.shared.numberOfUsers = result
        }
    }
}


extension RegisterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constant.shared.countryDialingCodes.count
    }
}


extension RegisterViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Constant.shared.countryDialingCodes[row].0 + " " + Constant.shared.countryDialingCodes[row].1
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return myTitle
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
        let countryCode = Constant.shared.countryDialingCodes[row].1
        let fileName = Constant.shared.countryDialingCodes[row].2
        
        flagImage.image = UIImage(named: fileName)
        codeCountryLabel.text = countryCode
        
        selectCountryPickerView.isHidden = true
    }
}


extension RegisterViewController: AuthAndRegisterProtocol {
    func unCorrectLoginPaswordOrEmptyField() {
        outletRegisterButton.isSelected = false
        let alertController = UIAlertController(title: "????????????",
                                                message: "???? ?????????????????? ?????? ????????",
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok", style: .default, handler:
                                        { _ in})
        alertController.addAction(buttonOk)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
            case userNameFromTextField:
                nameLabel.isHidden = false
            case phoneNumberFromTextField:
                phoneNumberLabel.isHidden = false
            case emailFromTextField:
                emailLabel.isHidden = false
            case passwordFromTextField:
                passwordLabel.isHidden = false
            case genderFromTextField:
                genderLabel.isHidden = false
                cardNumberLabel.isHidden = false
            case cardNumberFromTextField:
                cardNumberLabel.isHidden = false
                genderLabel.isHidden = false
            default:
                break
        }
    }
}
