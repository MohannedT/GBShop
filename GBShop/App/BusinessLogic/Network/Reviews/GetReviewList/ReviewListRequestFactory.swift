//
//  ReviewListRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation
import Alamofire

protocol ReviewListRequestFactory {
    func getReviewList(idProduct: Int, completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void)
}
