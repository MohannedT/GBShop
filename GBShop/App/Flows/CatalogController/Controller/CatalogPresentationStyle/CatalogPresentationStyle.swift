//
//  CatalogPresentationStyle.swift
//  GBShop
//
//  Created by Александр Ипатов on 16.03.2021.
//

import UIKit

enum PresentationStyle: String, CaseIterable {
    case table
    case defaultGrid
    var buttonImage: UIImage {
        switch self {
        case .table: return UIImage(systemName: "square.grid.2x2")!
        case .defaultGrid: return UIImage(systemName: "rectangle.grid.1x2")!
        }
    }
}
