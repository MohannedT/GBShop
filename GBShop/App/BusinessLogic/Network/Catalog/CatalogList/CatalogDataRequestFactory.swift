//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 19.02.2021.
//

import Foundation
import Alamofire

protocol CatalogDataRequestFactory {
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
}
