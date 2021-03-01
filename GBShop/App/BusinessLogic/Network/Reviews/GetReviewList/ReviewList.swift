//
//  ReviewList.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation
import Alamofire

class ReviewList: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        baseURL: URL,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.baseUrl = baseURL
        self.queue = queue
    }
}

extension ReviewList: ReviewListRequestFactory {
    func getReviewList(idProduct: Int, completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void) {
        let requestModel = RevList(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension ReviewList {
    struct RevList: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getReviewList"

        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct
            ]
        }
    }
}
