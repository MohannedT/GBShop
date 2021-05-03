//
//  Review.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct Review: Codable, Hashable {
    let username: String
    let text: String
    let productMark: Int

    enum CodingKeys: String, CodingKey {
        case username
        case text
        case productMark = "mark"
    }
}
