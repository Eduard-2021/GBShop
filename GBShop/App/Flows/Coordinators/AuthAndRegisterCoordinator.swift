//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class AuthAndRegisterCoordinator: Coordinator, AuthAndRegisterProtocol {
    var navigationController = UINavigationController()
    var tabBarVC: CreateTabBarController?

    func start() -> UIViewController {
        let vc = ViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
}
