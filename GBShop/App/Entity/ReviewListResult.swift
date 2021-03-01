//
//  ReviewListResult.swift
//  GBShop
//
//  Created by Александр Ипатов on 01.03.2021.
//

import Foundation

struct ReviewListResult: Codable {
    let result: Int
    let reviews: [Review]
}
