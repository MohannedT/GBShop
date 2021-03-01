//
//  ChangeUserData.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
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

extension ChangeUserData: ChangeUserDataRequestFactory {
    func changeUserData(idUser: Int, userName: String, password: String, email: String, gender: Character, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = Change(baseUrl: baseUrl, idUser: idUser, username: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    }

extension ChangeUserData {
    struct Change: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeData"

        let idUser: Int
        let username: String
        let password: String
        let email: String
        let gender: Character
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio

            ]
        }
    }
}
