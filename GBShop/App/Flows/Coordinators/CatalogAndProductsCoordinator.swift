//
//  CatalogAndProductsCoordinator.swift
//  GBShop
//
//  Created by Eduard on 18.01.2022.
//

import UIKit

class CatalogAndProductsCoordinator: Coordinator, DescriptionAndReviewsProtocol {
    var navigationController = UINavigationController()
    weak var tabBarVC: CreateTabBarController?

    func start() -> UIViewController {
        let vc = CatalogViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
    
    func openProductsViewController(idCategory: Int, categoryName: String){
        let vc = ProductsViewController.createObject()
        vc.idCategory = idCategory
        vc.categoryName = categoryName
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

