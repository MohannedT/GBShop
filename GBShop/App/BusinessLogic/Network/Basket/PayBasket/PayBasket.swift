//
//  PayBasket.swift
//  GBShop
//
//  Created by Александр Ипатов on 10.03.2021.
//

import Foundation
import Alamofire

class PayBasket: AbstractRequestFactory {
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

extension PayBasket: PayBasketRequestFactory {
    func payBasket(idUser: Int, paymentAmount: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = Pay(baseUrl: baseUrl, idUser: idUser, paymentAmount: paymentAmount)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension PayBasket {
    struct Pay: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"

        let idUser: Int
        let paymentAmount: Int
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "payment_amount": paymentAmount
            ]
        }
    }
}
