//
//  CreateTabBarController.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class CreateTabBarController: UITabBarController {
    
    let authAndRegisterCoordinator = AuthAndRegisterCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    func start() {
        authAndRegisterCoordinator.tabBarVC = self
        
        var controllers = [UIViewController]()
        let mainViewController = MainViewController.createObject()
        let сatalogViewController = CatalogViewController.createObject()
        let loginViaPhoneNumberViewController = authAndRegisterCoordinator.start()
        let basketViewController = BasketViewController.createObject()

        
        mainViewController.title = "Главная"
        сatalogViewController.title = "Каталог"
        loginViaPhoneNumberViewController.title = "Профиль"
        basketViewController.title = "Корзина"
        
        controllers.append(contentsOf: [mainViewController, сatalogViewController,loginViaPhoneNumberViewController, basketViewController])

        self.setViewControllers(controllers, animated: false)
        
        let images = ["house.fill", "square.grid.2x2", "person", "cart" ]
        guard let items = self.tabBar.items else {return}
        for x in 0...3 {
            items[x].image = UIImage(systemName: images[x])
        }
        
        let mainColorForSearchBar = UIColor(red: 126/255, green: 187/255, blue: 59/255, alpha: 1)
        self.tabBar.backgroundColor = mainColorForSearchBar
        self.tabBar.tintColor = .white
        self.tabBar.backgroundImage = UIImage()
    }
    
    func authAndRegisterCompleted() {
        Constant.shared.isAuth = true
        DispatchQueue.main.async {
            let allViewControllersOfTabBar = self.viewControllers

            let changeDataViewController = ChangeDataViewController.createObject()
            changeDataViewController.tabBarVC = self
            
            guard var allViewControllersOfTabBar = allViewControllersOfTabBar else {return}
            
            var AuthOrChangeDataViewControllerNumber = 0
            for (index,viewController) in allViewControllersOfTabBar.enumerated() {
                if viewController.title == "Профиль" {
                    AuthOrChangeDataViewControllerNumber = index
                }
            }
     
            allViewControllersOfTabBar[AuthOrChangeDataViewControllerNumber] = changeDataViewController
            
            self.setViewControllers(allViewControllersOfTabBar, animated: false)
            
            changeDataViewController.title = "Профиль"
            guard let items = self.tabBar.items else {return}
            items[AuthOrChangeDataViewControllerNumber].image = UIImage(systemName: "person")
        
            self.selectedIndex = 0
        }
    }
    
    func logoutCompleted() {
        Constant.shared.isAuth = false
        DispatchQueue.main.async {
            let allViewControllersOfTabBar = self.viewControllers

            let loginViaPhoneNumberViewController = self.authAndRegisterCoordinator.start()
            
            guard var allViewControllersOfTabBar = allViewControllersOfTabBar else {return}
            
            var AuthOrChangeDataViewControllerNumber = 0
            for (index,viewController) in allViewControllersOfTabBar.enumerated() {
                if viewController.title == "Профиль" {
                    AuthOrChangeDataViewControllerNumber = index
                }
            }
     
            allViewControllersOfTabBar[AuthOrChangeDataViewControllerNumber] = loginViaPhoneNumberViewController
            
            self.setViewControllers(allViewControllersOfTabBar, animated: false)
            
            loginViaPhoneNumberViewController.title = "Профиль"
            guard let items = self.tabBar.items else {return}
            items[AuthOrChangeDataViewControllerNumber].image = UIImage(systemName: "person")
        
            self.selectedIndex = 0
        }
    }
    
    
}
