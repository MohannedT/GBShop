//
//  GetBasketREqestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 22.03.2021.
//

import Foundation
import Alamofire

protocol GetBasketREqestFactory {
    func getBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)
}
