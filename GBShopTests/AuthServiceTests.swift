//
//  AuthServiceTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 14.03.2021.
//
import XCTest
@testable import GBShop

class AuthServiceTests: XCTestCase {
    func testLogin() throws {
        let testLogin = expectation(description: "login")
        let authService = AuthService()
        authService.login(userName: "Somebody", password: "ivanIvanov@!awdw1") { (result) in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.idUser, 123)
                XCTAssertEqual(user.email, "jonDoe@gmail.com")
                XCTAssertEqual(user.username, "Jon Doe")
                XCTAssertEqual(user.gender, "m")
                XCTAssertEqual(user.creditCard, "1111111111111111")
                XCTAssertEqual(user.bio, "Hey! I want to buy something")
                testLogin.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
    }
        waitForExpectations(timeout: 10)
    }
    func testRegister() throws {
        let testRegister = expectation(description: "Register")
        let authService = AuthService()
        authService.register(userName: "Somebody",
                                    password: "ivanIvanov@!awdw1",
                                    email: "some@some.ru",
                                    conconfirmPassword:  "ivanIvanov@!awdw1",
                                    gender: "m",
                                    creditCard: "1111111111111111",
                                    bio: "This is good! I think I will switch to another language") { (result) in
            switch result {
            case .success(let register):
                XCTAssertEqual(register.email, "some@some.ru")
                testRegister.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
    }
        waitForExpectations(timeout: 10)
    }
    func testChangeData() throws {
        let testChangeData = expectation(description: "ChangeData")
        let authService = AuthService()
        authService.changeUserData(idUser: 123,
                                          userName: "Somebody",
                                    password: "ivanIvanov@!awdw1",
                                    email: "some@some.ru",
                                    conconfirmPassword:  "ivanIvanov@!awdw1",
                                    gender: "m",
                                    creditCard: "1111111111111111",
                                    bio: "This is good! I think I will switch to another language") { (result) in
            switch result {
            case .success(let changeData):
                XCTAssertEqual(changeData.email, "some@some.ru")
                testChangeData.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
    }
        waitForExpectations(timeout: 10)
    }
}
