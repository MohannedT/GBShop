//
//  ProductWithDecription.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct ProductWithDecription: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}
