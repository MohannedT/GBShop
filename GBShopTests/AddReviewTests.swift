//
//  AddReviewTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 01.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AddReviewTests: XCTestCase {

    func testAddReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = AddReview(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseURL: baseUrl,
                            queue: DispatchQueue.global(qos: .utility))

        let addedReviw = expectation(description: "Review added")

        rev.addReview(idUser: 123, text: "Текст отзыва") { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                XCTAssertEqual(rev.userMessage, "Ваш отзыв был передан на модерацию")
                addedReviw.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedAddReview() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = AddReview(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseURL: baseUrl,
                            queue: DispatchQueue.global(qos: .utility))

        let failedgaddReview = expectation(description: "failed add reviw")

        rev.addReview(idUser: 123, text: "Текст отзыва") { (response) in
            switch response.result {
            case .success(let rev):
                XCTFail("must have failed: \(rev)")
            case .failure:
                failedgaddReview.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
