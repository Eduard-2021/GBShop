//
//  DescriptionAndReviewsProtocol.swift
//  GBShop
//
//  Created by Eduard on 23.01.2022.
//

import UIKit

protocol DescriptionAndReviewsProtocol: AuthAndRegisterProtocol {
    var navigationController: UINavigationController {get set}
    func openProductDescriptionViewController(product: OneProduct)
    func openProductReviewsViewController(product: OneProduct)
    func openCreatingReviewViewController(product: OneProduct)
}


extension DescriptionAndReviewsProtocol {
    
    func openProductDescriptionViewController(product: OneProduct){
        let vc = ProductDescriptionViewController.createObject()
        vc.product = product
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openProductReviewsViewController(product: OneProduct){
        let vc = ProductReviewsViewController.createObject()
        vc.product = product
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openCreatingReviewViewController(product: OneProduct){
        let vc = CreatingReviewViewController.createObject()
        vc.product = product
        vc.coordinator = self
//        self.navigationController.popViewController(animated: false)
        navigationController.pushViewController(vc, animated: false)
    }
}
