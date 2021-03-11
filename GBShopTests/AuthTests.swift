//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthTests: XCTestCase {

    func testLogIn() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let auth = Auth(errorParser: ErrorParser(),
                        sessionManager: session,
                        baseURL: baseUrl,
                        queue: DispatchQueue.global(qos: .utility))

        let loggedIn = expectation(description: "loggedIn")

        auth.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.result, 1)
                XCTAssertEqual(login.user.idUser, 123)
                XCTAssertEqual(login.user.login, "geekbrains")
                XCTAssertEqual(login.user.name, "John")
                XCTAssertEqual(login.user.lastname, "Doe")

                loggedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedLogIn() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let auth = Auth(errorParser: ErrorParser(),
                        sessionManager: session,
                        baseURL: baseUrl,
                        queue: DispatchQueue.global(qos: .utility))

        let failedloggedIn = expectation(description: "failed to log In")

        auth.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let login):
                XCTFail("must have failed: \(login)")

            case .failure:
                failedloggedIn.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
