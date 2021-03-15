//
//  DeleteFromBasketTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 10.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class DeleteFromBasketTests: XCTestCase {

    func testDeleteFromBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = DeleteFromBasket(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseURL: baseUrl,
                             queue: DispatchQueue.global(qos: .utility))

        let gotReviewList = expectation(description: "Delete From Basket")

        rev.deleteFromBasket(idProduct: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedDeleteFromBasket() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = DeleteFromBasket(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseURL: baseUrl,
                             queue: DispatchQueue.global(qos: .utility))

        let failedGetReviewList = expectation(description: "failed Delete From Basket")

        rev.deleteFromBasket(idProduct: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTFail("must have failed: \(rev)")
            case .failure:
                failedGetReviewList.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
