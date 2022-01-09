//
//  LoginViaEmailViewController.swift
//  GBShop
//
//  Created by Eduard on 03.01.2022.
//

import UIKit

class LoginViaEmailViewController: UIViewController, Storyboardable {
    
    weak var coordinator: AuthAndRegisterCoordinator?
    weak var tabBarVC: CreateTabBarController?
    
    private let homeworkCallFromOneToSix = HomeworkCallFromOneToSix()
    private let authAndRegistration = AuthAndRegistration()
    
    @IBOutlet weak var outletLoginButton: UIButton!
    @IBOutlet weak var emailFromTextField: UITextField!
    @IBOutlet weak var passwordFromTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        outletLoginButton.isSelected = true
        guard let emailFromTextField = emailFromTextField.text, let passwordFromTextField = passwordFromTextField.text else {return}
        authAndRegistration.login(email: emailFromTextField, password: passwordFromTextField){ isCorrect in
            if isCorrect {
                self.tabBarVC?.authAndRegisterCompleted()
                let ttt = 0//Переход на слудующий экран
            }
        }
    }
    
    @IBAction func turnToPhoneNumberAuth(_ sender: Any) {
        coordinator?.openLoginViaPhotoNumberViewController()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        coordinator?.openRegisterViewController()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authAndRegistration.loginAndRegisterViewControllerDelegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
        UIView.setAnimationsEnabled(false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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


extension LoginViaEmailViewController: AuthAndRegisterProtocol {
    func unCorrectLoginPaswordOrEmptyField() {
        outletLoginButton.isSelected = false
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Неверный почтовый ящик или пароль",
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok", style: .default, handler:
                                        { _ in self.emailFromTextField.text = ""
                                            self.passwordFromTextField.text = ""
                                        })
        alertController.addAction(buttonOk)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

