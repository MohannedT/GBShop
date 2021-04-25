//
//  CatalogCellModelFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 16.03.2021.
//

import UIKit

final class CatalogCellModelFactory {
    static func cellModel(from model: Product) -> CatalogCellModel {
        return CatalogCellModel(productImage: model.photo, price: String(model.price), title: model.productName)
    }
}
