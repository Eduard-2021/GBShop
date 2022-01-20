//
//  MainAndProductsCoordinator.swift
//  GBShop
//
//  Created by Eduard on 19.01.2022.
//

import UIKit

class MainAndProductsCoordinator: Coordinator {
    var navigationController = UINavigationController()
    weak var tabBarVC: CreateTabBarController?

    func start() -> UIViewController {
        let vc = MainViewController.createObject()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
    
    func openProductDescriptionViewController(product: OneProduct){
        let vc = ProductDescriptionViewController.createObject()
        vc.product = product
        vc.coordinator = CatalogAndProductsCoordinator()
        navigationController.pushViewController(vc, animated: false)
    }
}
