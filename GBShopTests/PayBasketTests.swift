//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 10.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class PayBasketTests: XCTestCase {

    func testPayBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = PayBasket(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseURL: baseUrl,
                             queue: DispatchQueue.global(qos: .utility))

        let gotReviewList = expectation(description: "Pay Basket")

        rev.payBasket(idUser: 123, paymentAmount: 20002) { (response) in
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

    func testFailedPayBasket() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = PayBasket(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseURL: baseUrl,
                             queue: DispatchQueue.global(qos: .utility))

        let failedGetReviewList = expectation(description: "failed Pay Basket")

        rev.payBasket(idUser: 123, paymentAmount: 20002) { (response) in
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
