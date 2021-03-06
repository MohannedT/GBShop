//
//  Auth.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "auth"

        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}
