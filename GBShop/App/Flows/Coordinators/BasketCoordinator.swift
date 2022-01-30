//
//  BasketCoordinator.swift
//  GBShop
//
//  Created by Eduard on 27.01.2022.
//

import UIKit

class BasketCoordinator: Coordinator {
    var navigationController = UINavigationController()
    var tabBarVC: CreateTabBarController?

    func start() -> UIViewController {
        let vc = BasketViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
        return navigationController
    }
    
    func openCheckoutStep1ViewController(){
        let vc = CheckoutStep1ViewController.createObject()
        vc.coordinator = self
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openTypeOfDeliveryViewController(checkVC: CheckoutStep1ViewController, deliveryMethod: (Int,Int)){
        let vc = TypeOfDeliveryViewController.createObject()
        vc.coordinator = self
        vc.delegate = checkVC
        vc.deliveryMethod = deliveryMethod
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openPaymentTypeViewController(checkVC: CheckoutStep1ViewController, paymentMethod: Int, account: Int){
        let vc = PaymentTypeViewController.createObject()
        vc.coordinator = self
        vc.delegate = checkVC
        vc.paymentMethod = paymentMethod
        vc.account = account
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openTimeOfDeliveryViewController(checkVC: CheckoutStep1ViewController, deliveryTimeOption: Int){
        let vc = TimeOfDeliveryViewController.createObject()
        vc.coordinator = self
        vc.delegate = checkVC
        vc.deliveryTimeOption = deliveryTimeOption
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openOrderNumberPageViewController(deliveryAndPaymentMethodsTimeAndSumm: [String]){
        let vc = OrderNumberPageViewController.createObject()
        vc.coordinator = self
        vc.deliveryAndPaymentMethodsTimeAndSumm = deliveryAndPaymentMethodsTimeAndSumm
        vc.tabBarVC = tabBarVC
        navigationController.pushViewController(vc, animated: false)
    }
}
