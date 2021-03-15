//
//  PayBasketRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 10.03.2021.
//

import Foundation

import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(idUser: Int, paymentAmount: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
