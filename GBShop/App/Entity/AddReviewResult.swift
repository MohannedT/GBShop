//
//  AddReviewResult.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct AddReviewResult: Codable {
    let userMessage: String
    let result: Int

    enum CodingKeys: String, CodingKey {
        case userMessage = "user_message"
        case result
    }
}
