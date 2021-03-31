//
//  User.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation

struct User: Codable, Hashable {
    let idUser: Int
    let username, email: String
    let gender, creditCard, bio: String

    enum CodingKeys: String, CodingKey {
        case username, email
        case idUser = "id_user"
        case gender
        case creditCard = "credit_card"
        case bio
    }
}

