//
//   MessageProductPlacedBasketProtocol.swift
//  GBShop
//
//  Created by Eduard on 24.01.2022.
//

import UIKit

protocol MessageProductPlacedBasketProtocol{
    var isBuyButtonPressed: Bool {get set}
    func messageProductPlacedBasket(product:OneProduct)
}
