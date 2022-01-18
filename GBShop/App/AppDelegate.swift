//
//  AppDelegate.swift
//  GBShop
//
//  Created by Eduard on 27.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        if let baseUrl = URL(string: "http://127.0.0.1:8080/") {
        
        if let baseUrl = URL(string: "http://secret-escarpment-71481.herokuapp.com/") {
            
            Constant.shared.baseURL = baseUrl
            window?.rootViewController = CreateTabBarController()
        }
        else {
            window?.rootViewController = UnCorrectURLViewController.createObject()
        }

        window?.makeKeyAndVisible()
        return true
    }


}

