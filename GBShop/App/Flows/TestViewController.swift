//
//  TestViewController.swift
//  GBShop
//
//  Created by Eduard on 28.01.2022.
//

import UIKit

class TestViewController: UIViewController, Storyboardable {
 
    var coordinator: DescriptionAndReviewsProtocol?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 2000)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
