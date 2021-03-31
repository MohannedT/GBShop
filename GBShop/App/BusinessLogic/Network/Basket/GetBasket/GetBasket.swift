//
//  GetBasket.swift
//  GBShop
//
//  Created by Александр Ипатов on 22.03.2021.
//

import Foundation
import Alamofire

class GetBasket: AbstractRequestFactory {
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

extension GetBasket: GetBasketREqestFactory {
    func getBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GetBasket {
    struct GetBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"

        let idUser: Int
        var parameters: Parameters? {
            return [
                "id_user": idUser
            ]
        }
    }
}
