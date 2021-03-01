//
//  ReviewListTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 01.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ReviewListTests: XCTestCase {

    func testReviewList() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = ReviewList(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))

        let gotReviewList = expectation(description: "Got Review List")

        rev.getReviewList(idProduct: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                XCTAssertEqual(rev.reviews.count, 2)
                XCTAssertEqual(rev.reviews.first?.idUser, 123)
                XCTAssertEqual(rev.reviews.first?.text, "Текст отзыва")
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedReviewList() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = ReviewList(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))

        let failedGetReviewList = expectation(description: "failed get review list")

        rev.getReviewList(idProduct: 123) { (response) in
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
