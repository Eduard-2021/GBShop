//
//  BackShadow.swift
//  GBShop
//
//  Created by Eduard on 25.01.2022.
//

import UIKit

@IBDesignable class BackShadow: UIView {

    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 5.0, height: 5)
    @IBInspectable var shadowOpacity: Float = 0.9
    @IBInspectable var shadowRadius: CGFloat = 3
    
    
    override func awakeFromNib() {
//        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        
    
    }
}
