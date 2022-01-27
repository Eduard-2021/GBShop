//
//  Coordinator.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()  -> UIViewController
}
