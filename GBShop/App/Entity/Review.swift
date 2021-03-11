//
//  Review.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct Review: Codable {
    let idUser: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case idUser = "id_user"
        case text
    }
}
