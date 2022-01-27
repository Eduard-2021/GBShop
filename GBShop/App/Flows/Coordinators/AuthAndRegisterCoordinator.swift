//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class AuthAndRegisterCoordinator: Coordinator {
    var navigationController = UINavigationController()
    weak var tabBarVC: CreateTabBarController?

    func start() -> UIViewController {
        let vc = ViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
    
    func openLoginViaEmailViewController(){
        let vc = LoginViaEmailViewController.createObject()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openLoginViaPhotoNumberViewController() {
        let vc = ViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openRegisterViewController() {
        let vc = RegisterViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
}
