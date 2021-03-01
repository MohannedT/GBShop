//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getProduct(idProduct: Int, completionHandler: @escaping (AFDataResponse<ProductWithDecription>) -> Void)
}
