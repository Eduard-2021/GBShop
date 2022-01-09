//
//  MainViewController.swift
//  GBShop
//
//  Created by Eduard on 07.01.2022.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        setSearchBar()
    }
    

    private func setSearchBar(){
        let mainColorForSearchBar = UIColor(red: 126/255, green: 187/255, blue: 59/255, alpha: 1)
        searchBar.setPlaceholderTextColorTo(textColor: mainColorForSearchBar, placeholderTextColor: UIColor.gray, backgroundColor: UIColor.white, leftViewColor: mainColorForSearchBar)
    }
}


extension UISearchBar
{
    func setPlaceholderTextColorTo(textColor: UIColor, placeholderTextColor: UIColor, backgroundColor: UIColor, leftViewColor: UIColor)
    {
        self.backgroundImage = UIImage()
        if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = textColor
            textFieldInsideSearchBar.backgroundColor = backgroundColor
            if let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel {
                textFieldInsideSearchBarLabel.textColor = placeholderTextColor
            }
            if let leftView = textFieldInsideSearchBar.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = leftViewColor
            }
        }
    }
}
