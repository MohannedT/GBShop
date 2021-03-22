//
//  ChangeUserDataRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

protocol ChangeUserDataRequestFactory {
    func changeUserData(idUser: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
