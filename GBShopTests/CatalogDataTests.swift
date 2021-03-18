//
//  CatalogDataTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class CatalogDataTests: XCTestCase {

    func testGetCatalog() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let catalog = CatalogData(errorParser: ErrorParser(),
                                  sessionManager: session,
                                  baseURL: baseUrl,
                                  queue: DispatchQueue.global(qos: .utility))

        let getCatalog = expectation(description: "get catalog")

        catalog.getCatalog(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let catalog):
                XCTAssertEqual(catalog.products.first?.idProduct, 123)
                XCTAssertEqual(catalog.products.first?.productName,
                               "Ноутбук Apple MacBook Air 13 Late 2020 (Apple M1/13.3/2560x1600/8GB/256GB SSD/DVD нет/Apple graphics 7-core/Wi-Fi/macOS)")
                XCTAssertEqual(catalog.products.first?.price, 125000)
                XCTAssertEqual(catalog.products[1].idProduct, 456)
                XCTAssertEqual(catalog.products[1].productName,
                               "Ноутбук Apple MacBook Pro 13 Late 2020 (Apple M1/13/2560x1600/8GB/256GB SSD/DVD нет/Apple graphics 8-core/Wi-Fi/Bluetooth/macOS)")
                XCTAssertEqual(catalog.products[1].price, 100000)
                getCatalog.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

        }
        waitForExpectations(timeout: 10)
    }

    func testFailedGetCatalog() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let catalog = CatalogData(errorParser: ErrorParser(),
                                  sessionManager: session,
                                  baseURL: baseUrl,
                                  queue: DispatchQueue.global(qos: .utility))

        let failedloggedIn = expectation(description: "failed to get catalog")

        catalog.getCatalog(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let catalog):
                XCTFail("must have failed: \(catalog)")
            case .failure:
                failedloggedIn.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
