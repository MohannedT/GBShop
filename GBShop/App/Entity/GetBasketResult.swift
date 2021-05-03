//
//  getBasketResult.swift
//  GBShop
//
//  Created by Александр Ипатов on 22.03.2021.
//

import Foundation

struct GetBasketResult: Codable {
    var amount: Int
    var contents: [Product]
    var countGoods: Int
}
