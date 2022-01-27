//
//  ChangeDataViewController.swift
//  GBShop
//
//  Created by Eduard on 08.01.2022.
//

import UIKit

class ChangeDataViewController: UIViewController, Storyboardable {
    
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
    @IBOutlet weak var outletChangeDataButton: UIButton!
    
    
    
    //MARK: - ChangeDataButton
    @IBAction func changeDataButtonPressed(_ sender: Any) {
        outletChangeDataButton.isSelected = true
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
            cardNumberFromTextField == ""
        {
            unCorrectLoginPaswordOrEmptyField()
        }
        else {
            let countryCode = Constant.shared.countryDialingCodes[selectRow].1
            guard let user = Constant.shared.user else {return}
            
            let newUser = NewUser(
            idUser: user.idUser,
            userName: userNameFromTextField,
            password: passwordFromTextField,
            email: emailFromTextField,
            phoneNumber: countryCode + " " + phoneNumberFromTextField,
            gender: genderFromTextField,
            creditCard: cardNumberFromTextField,
            bio: "")
            
            Constant.shared.user = newUser
            
            authAndRegistration.changeData(newUser: newUser) { isCorrect in
                if isCorrect {
                    self.tabBarVC?.authAndRegisterCompleted()
                }
            }
        }
    }
    
    @IBAction func changeCountryButtonPressed(_ sender: Any) {
        selectCountryPickerView.isHidden = false
    }
    
    //MARK: - LogoutButton
    @IBAction func logoutButton(_ sender: Any) {
        guard let idUser = Constant.shared.user?.idUser else {return}
        authAndRegistration.logout(idUser: idUser) {isCorrect in
            if isCorrect {
                self.tabBarVC?.logoutCompleted()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNumberOfUsers()
        selectCountryPickerView.dataSource = self
        selectCountryPickerView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
        loadPrivateDateInFields()
    }
    
    //MARK: - Load Field
    private func loadPrivateDateInFields(){
        emailFromTextField.text = Constant.shared.user?.email
        passwordFromTextField.text = Constant.shared.user?.password
        userNameFromTextField.text = Constant.shared.user?.userName
        genderFromTextField.text = Constant.shared.user?.gender
        cardNumberFromTextField.text = Constant.shared.user?.creditCard
        
        let fullPhoneNumber = Constant.shared.user?.phoneNumber
        var fullPhoneNumberInArrayType = fullPhoneNumber?.split(separator: " ")
        let countryCodeSub = fullPhoneNumberInArrayType?.remove(at: 0)
        guard let countryCodeSub = countryCodeSub else {return}
        let countryCode = String(countryCodeSub)
        let onlyPhoneNumber = fullPhoneNumberInArrayType?.joined(separator: " ")
        guard let onlyPhoneNumber = onlyPhoneNumber else {return}
        phoneNumberFromTextField.text = onlyPhoneNumber
        
        guard let numberCountry = Constant.shared.countryDialingCodes.firstIndex(where: {$0.1 == countryCode}) else {return}
        selectCountryPickerView.selectRow(numberCountry, inComponent: 0, animated: false)
        
        let fileName = Constant.shared.countryDialingCodes[numberCountry].2
        flagImage.image = UIImage(named: fileName)
        codeCountryLabel.text = countryCode
        selectRow = numberCountry
    }
    
    // MARK: - Work with keyboard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // Второе — когда она пропадает
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
    // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    //Когда клавиатура исчезает 
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    private func fetchNumberOfUsers(){
        authAndRegistration.numberOfUsers{result in
            Constant.shared.numberOfUsers = result
        }
    }
}

// MARK: - Picker
extension ChangeDataViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constant.shared.countryDialingCodes.count
    }
}


extension ChangeDataViewController: UIPickerViewDelegate {

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

//MARK: - Alert

extension ChangeDataViewController: AuthAndRegisterProtocol {
    func unCorrectLoginPaswordOrEmptyField() {
        outletChangeDataButton.isSelected = false
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
