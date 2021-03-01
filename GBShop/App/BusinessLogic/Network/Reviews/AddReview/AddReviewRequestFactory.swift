//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}
