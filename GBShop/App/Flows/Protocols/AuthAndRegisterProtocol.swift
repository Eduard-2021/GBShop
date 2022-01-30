//
//  AuthAndRegisterProtocol.swift
//  GBShop
//
//  Created by Eduard on 23.01.2022.
//

import UIKit

protocol AuthAndRegisterProtocol{
    var navigationController: UINavigationController {get set}
    var tabBarVC: CreateTabBarController? {get set}
    
    func openLoginViaEmailViewController(isCreatingReview: Bool)
    func openLoginViaPhoneNumberViewController(isCreatingReview: Bool)
    func openRegisterViewController(isCreatingReview: Bool)
    
}

extension AuthAndRegisterProtocol {
    func openLoginViaEmailViewController(isCreatingReview: Bool){
        let vc = LoginViaEmailViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        vc.isCreatingReview = isCreatingReview
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openLoginViaPhoneNumberViewController(isCreatingReview: Bool) {
        let vc = ViewController.createObject()
        vc.coordinator = self
        vc.isCreatingReview = isCreatingReview
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openRegisterViewController(isCreatingReview: Bool) {
        let vc = RegisterViewController.createObject()
        vc.coordinator = self
        vc.isCreatingReview = isCreatingReview
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
}
