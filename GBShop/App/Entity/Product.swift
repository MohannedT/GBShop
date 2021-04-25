//
//  Product.swift
//  GBShop
//
//  Created by Александр Ипатов on 19.02.2021.
//

import Foundation

struct Product: Codable, Hashable {
    let idProduct: Int
    let productName: String
    let price: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price
        case photo
    }
}
