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
        let baseUrl = try XCTUnwrap (URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let catalog = CatalogData(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))
        
        let getCatalog = expectation(description: "getCatalog")
        
        catalog.getCatalog(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let catalog):
                XCTAssertEqual(catalog.first?.idProduct, 123)
                XCTAssertEqual(catalog.first?.productName, "Ноутбук")
                XCTAssertEqual(catalog.first?.price, 45600)
                XCTAssertEqual(catalog[1].idProduct, 456)
                XCTAssertEqual(catalog[1].productName, "Мышка")
                XCTAssertEqual(catalog[1].price, 1000)
                getCatalog.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
                
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedGetCatalog() throws {
        
        let baseUrl = try XCTUnwrap (URL(string: "https://raw.githubusercontent.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let catalog = CatalogData(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))
        
        let failedloggedIn = expectation(description: "failed to log In")
        
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
