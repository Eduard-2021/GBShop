//
//  LoginViaPhoneNumberViewController.swift
//  GBShop
//
//  Created by Eduard on 27.11.2021.
//

import UIKit

class ViewController: UIViewController, Storyboardable {
    
    weak var coordinator: AuthAndRegisterCoordinator?
    weak var tabBarVC: CreateTabBarController?
    
    private let homeworkCallFromOneToSix = HomeworkCallFromOneToSix()
    private let authAndRegistration = AuthAndRegistration()
    private var selectRow = 1
    
    @IBOutlet weak var outletLoginButton: UIButton!
    @IBOutlet weak var phoneNumberFromTextField: UITextField!
    @IBOutlet weak var passwordFromTextField: UITextField!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var codeCountryLabel: UILabel!
    @IBOutlet weak var selectCountryPickerView: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBAction func turnToEmailAuth(_ sender: Any) {
        coordinator?.openLoginViaEmailViewController()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        outletLoginButton.isSelected = true
        guard let phoneNumberFromTextField = phoneNumberFromTextField.text, let passwordFromTextField = passwordFromTextField.text else {return}
        
        let countryCode = Constant.shared.countryDialingCodes[selectRow].1
        
        let fullPhoneNumber = countryCode + " " + phoneNumberFromTextField
        authAndRegistration.login(phoneNumber: fullPhoneNumber, password: passwordFromTextField){ isCorrect in
            if isCorrect {
                self.tabBarVC?.authAndRegisterCompleted()
                let ttt = 0//Переход на слудующий экран
            }
        }
    }
    
    @IBAction func changeCountryButtonPressed(_ sender: Any) {
        selectCountryPickerView.isHidden = false
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        coordinator?.openRegisterViewController()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        selectCountryPickerView.dataSource = self
        selectCountryPickerView.delegate = self
        selectCountryPickerView.selectRow(1, inComponent: 0, animated: false)
        authAndRegistration.loginAndRegisterViewControllerDelegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
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


extension ViewController: AuthAndRegisterProtocol {
    func unCorrectLoginPaswordOrEmptyField() {
        outletLoginButton.isSelected = false
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Неверный номер телефона или пароль",
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok", style: .default, handler:
                                        { _ in self.phoneNumberFromTextField.text = ""
                                            self.passwordFromTextField.text = ""
                                        })
        alertController.addAction(buttonOk)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
