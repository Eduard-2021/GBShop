//
//  BasketViewController.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class BasketViewController: UIViewController, Storyboardable {
    
    var coordinator: BasketCoordinator?
    weak var tabBarVC: CreateTabBarController?
    var selectedProducts = [(OneProduct, Int)]()
    
    let workWithBasket = WorkWithBasket()
    let authRegistrationAndWorkWithProducts = AuthRegistrationAndWorkWithProducts()
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var clearBasketButtonOutlet: UIButton!
    @IBOutlet weak var checkoutButtonOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func clearBasketButton(_ sender: Any) {
        // Constant.shared.selectedProducts = [] // работа с корзиной через Singlton
        workWithBasket.deleteProductsBasket(
            productToDelete: DeleteProductFromBasketRequest(idProduct: -1, productsNumber: 0)){}
        refrashTableView()
    }
    @IBAction func checkoutButton(_ sender: Any) {
        if Constant.shared.user != nil {
            coordinator?.openCheckoutStep1ViewController()
        } else {
            needLogin()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let cellName = UINib(nibName: "TableViewCellForBasketViewController", bundle: nil)
        tableView.register(cellName, forCellReuseIdentifier: "TableViewCellForBasketViewController")
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refrashTableView()
        configureButton()
        
        if  Constant.shared.whoCalledAuth == .basketViewController {
            Constant.shared.whoCalledAuth = .authViewController
            if Constant.shared.user != nil {
                coordinator?.openCheckoutStep1ViewController()
            }
        }
    }
    
    func refrashTableView(){
        
        workWithBasket.getBasket {basketFromServer in
            self.selectedProducts = []
            for oneProductInBasket in basketFromServer.basket {
                self.authRegistrationAndWorkWithProducts.getOneProduct(idProduct: oneProductInBasket.idProduct) {oneProduct in
                    guard let oneProduct = oneProduct else {return}
                    self.selectedProducts.append((oneProduct,oneProductInBasket.productsNumber ))
                    var totalPrice = 0
                    for oneProduct in  self.selectedProducts {
                        totalPrice += oneProduct.0.productPrice * oneProduct.1
                    }
                    DispatchQueue.main.async {
                        self.totalPriceLabel.text = "ИТОГО \(totalPrice) ₴"
                        self.tableView.reloadData()
                    }
                }
            }
            var totalPrice = 0
            for oneProduct in  self.selectedProducts {
                totalPrice += oneProduct.0.productPrice * oneProduct.1
            }
            DispatchQueue.main.async {
                self.totalPriceLabel.text = "ИТОГО \(totalPrice) ₴"
                self.tableView.reloadData()
            }
        }
        //selectedProducts = Constant.shared.selectedProducts // работа с корзиной через Singlton
    }
    
    private func configureButton(){
        let widthButton = checkoutButtonOutlet.frame.width
        checkoutButtonOutlet.layer.cornerRadius = widthButton / 20
    }
}


extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellForBasketViewController", for: indexPath) as? TableViewCellForBasketViewController else {return UITableViewCell()}
        cell.config(selectedProduct: selectedProducts[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
}


extension BasketViewController {
    
    func needLogin() {
        let alertController = UIAlertController(title: "Для продолжения оформления необходимо войти в учетную запись", message: nil,
                                                preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: { _ in
                                            self.tabBarVC?.selectedIndex = 2
                                            Constant.shared.whoCalledAuth = .basketViewController
                                     })
        alertController.addAction(buttonOk)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
