//
//  RegistrationRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func registration(idUser: Int, userName: String, password: String, email: String, gender: Character, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
