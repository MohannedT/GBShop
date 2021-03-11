//
//  RemoveReviewTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 01.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RemoveReviewTests: XCTestCase {

    func testRemoveReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = RemoveReview(errorParser: ErrorParser(),
                               sessionManager: session,
                               baseURL: baseUrl,
                               queue: DispatchQueue.global(qos: .utility))

        let removedReviw = expectation(description: "Review remved")

        rev.removeReview(idComment: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                removedReviw.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedRemoveReview() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let rev = RemoveReview(errorParser: ErrorParser(),
                               sessionManager: session,
                               baseURL: baseUrl,
                               queue: DispatchQueue.global(qos: .utility))

        let failedRemoveReview = expectation(description: "failed remove reviw")

        rev.removeReview(idComment: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTFail("must have failed: \(prod)")
            case .failure:
                failedRemoveReview.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
