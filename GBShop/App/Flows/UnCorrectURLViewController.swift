//
//  UNCorrectURLViewController.swift
//  GBShop
//
//  Created by Eduard on 09.01.2022.
//

import UIKit
import Alamofire

class UnCorrectURLViewController: UIViewController, Storyboardable {
    
    @IBAction func pressedExitButton(_ sender: Any) {
        exit(0)
              let noBtn = UIAlertAction(title:"Cancel" , style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
              exit(0)
            })
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
