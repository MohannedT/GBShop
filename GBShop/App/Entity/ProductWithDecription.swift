//
//  ProductWithDecription.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct ProductWithDescription: Codable, Hashable {
    let result: Int
    let productName: String
    let productDescription: String
    let productPrice: Int
    let productPhotos: [String]

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case result
        case productDescription = "product_description"
        case productPrice = "product_price"
        case productPhotos = "product_photos"
    }
}
