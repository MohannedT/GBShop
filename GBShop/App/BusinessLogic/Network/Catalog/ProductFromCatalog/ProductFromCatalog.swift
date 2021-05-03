//
//  ProductFromCatalog.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation
import Alamofire

class ProductFromCatalog: AbstractRequestFactory {
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

extension ProductFromCatalog: ProductRequestFactory {
    func getProduct(idProduct: Int, completionHandler: @escaping (AFDataResponse<ProductWithDescription>) -> Void) {
        let requestModel = ProductCatalog(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension ProductFromCatalog {
    struct ProductCatalog: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProduct"

        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct
            ]
        }
    }
}
