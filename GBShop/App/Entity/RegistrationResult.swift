//
//  RegistrationResult.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation

struct RegistrationResult: Codable {
    let userMessage: String
    let result: Int

    enum CodingKeys: String, CodingKey {
        case userMessage = "user_message"
        case result
    }
}
