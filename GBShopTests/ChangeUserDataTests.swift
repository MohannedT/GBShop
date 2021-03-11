//
//  ChangeUserDataTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ChangeUserDataTests: XCTestCase {

    func testChangeUserData() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let changeData = ChangeUserData(errorParser: ErrorParser(),
                                        sessionManager: session,
                                        baseURL: baseUrl,
                                        queue: DispatchQueue.global(qos: .utility))
        let changedData = expectation(description: "ChangedData")

        changeData.changeUserData(idUser: 123,
                                  userName: "Somebody",
                                  password: "mypassword",
                                  email: "some@some.ru",
                                  gender: "m",
                                  creditCard: "credit_card",
                                  bio: "This is good! I think I will switch to another language") { (response) in
            switch response.result {
            case .success(let change):
                XCTAssertEqual(change.result, 1)
                changedData.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedChangeUserData() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let changeData = ChangeUserData(errorParser: ErrorParser(),
                                        sessionManager: session,
                                        baseURL: baseUrl,
                                        queue: DispatchQueue.global(qos: .utility))
        let failedChangeData = expectation(description: "ChangedData")

        changeData.changeUserData(idUser: 123, userName: "Somebody",
                                  password: "mypassword",
                                  email: "some@some.ru",
                                  gender: "m",
                                  creditCard: "credit_card",
                                  bio: "This is good! I think I will switch to another language") { (response) in
            switch response.result {
            case .success(let change):
                XCTFail("must have failed: \(change)")
            case .failure:
                failedChangeData.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
