//
//  DeleteFromBasketRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 10.03.2021.
//

import Foundation

import Alamofire

protocol DeleteFromBasketRequestFactory {
    func deleteFromBasket(idProduct: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
}
