//
//  addToBasketRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 10.03.2021.
//

import Foundation

import Alamofire

protocol AddToBasketRequestFactory {
    func addToBasket(idProduct: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
}
