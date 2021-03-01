//
//  ProductFromCatalogTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 01.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductFromCatalogTests: XCTestCase {

    func testproductFromCatalog() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let prod = ProductFromCatalog(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))

        let gotProd = expectation(description: "Got Prod")

        prod.getProduct(idProduct: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTAssertEqual(prod.result, 1)
                XCTAssertEqual(prod.productName, "Ноутбук")
                XCTAssertEqual(prod.productPrice, 45600)
                   XCTAssertEqual(prod.productDescription, "Мощный игровой ноутбук")
                gotProd.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedProductFromCatalog() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let prod = ProductFromCatalog(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))
        let failedgetProf = expectation(description: "failed get prod")

        prod.getProduct(idProduct: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTFail("must have failed: \(prod)")
            case .failure:
                failedgetProf.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
