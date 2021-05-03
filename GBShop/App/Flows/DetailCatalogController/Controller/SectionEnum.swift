//
//  SectionEnum.swift
//  GBShop
//
//  Created by Александр Ипатов on 21.03.2021.
//

import Foundation

enum Section: Int, CaseIterable {
    case photos, info, addReview, review

    func description() -> String {
        switch self {
        case .photos:
            return "Photos"
        case .info:
            return "About product"
        case .addReview:
            return "Add review"
        case .review:
            return "Product reviews"
        }
    }
}
