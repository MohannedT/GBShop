//
//  RegistrationTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RegistrationTests: XCTestCase {

    func testRegistration() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let reg = Registration(errorParser: ErrorParser(),
                               sessionManager: session,
                               baseURL: baseUrl,
                               queue: DispatchQueue.global(qos: .utility))

        let registered = expectation(description: "Registered")

        reg.registration(idUser: 123, userName: "Somebody",
                         password: "mypassword",
                         email: "some@some.ru",
                         gender: "m",
                         creditCard: "credit_card",
                         bio: "This is good! I think I will switch to another language") { (response) in
            switch response.result {
            case .success(let reg):
                XCTAssertEqual(reg.result, 1)
                XCTAssertEqual(reg.userMessage, "Регистрация прошла успешно!")

                registered.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedRegistration() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let reg = Registration(errorParser: ErrorParser(),
                               sessionManager: session,
                               baseURL: baseUrl,
                               queue: DispatchQueue.global(qos: .utility))

        let failedRegistration = expectation(description: "failedRegistration")

        reg.registration(idUser: 123,
                         userName: "Somebody",
                         password: "mypassword",
                         email: "some@some.ru",
                         gender: "m",
                         creditCard: "credit_card",
                         bio: "This is good! I think I will switch to another language") { (response) in
            switch response.result {
            case .success(let reg):
                XCTFail("must have failed: \(reg)")
            case .failure:
                failedRegistration.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
