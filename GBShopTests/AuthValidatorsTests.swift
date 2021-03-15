//
//  AuthValidatorsTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 14.03.2021.
//

import XCTest
@testable import GBShop

class AuthValidatorsTests: XCTestCase {
    func testIsFilledLogIn() throws {
        let isFilledLogIn = expectation(description: "username and password are filled in")
        if Validators.isFilledLogIn(login: "Somebody", password: "mypassword") {
            isFilledLogIn.fulfill()
        } else {
            XCTFail("testIsFilledLogIn failed")
        }
        waitForExpectations(timeout: 10)
    }
    func testIsFilledRegister() throws {
        let isFilledRegister = expectation(description: "Sign up data are filled in")
        if  Validators.isFilledRegister(userName: "Somebody",
                                        email: "some@some.ru",
                                        password: "mypassword",
                                        confirmPassword: "mypassword",
                                        gender: "m",
                                        creditCard: "credit_card",
                                        bio: "This is good! I think I will switch to another language") {
            isFilledRegister.fulfill()
        } else {
            XCTFail("isFilledRegister failed")
        }
        waitForExpectations(timeout: 10)
    }
    func testIsSimpleEmail() throws {
        let isSimpleEmail = expectation(description: "The email format is correct")
        if Validators.isSimpleEmail("some@some.ru") {
            isSimpleEmail.fulfill()
        } else {
            XCTFail("isSimpleEmail failed")
        }
        waitForExpectations(timeout: 10)
    }
    func testIsSimpleCreditCard() throws {
        let isSimpleCreditCard = expectation(description: "The credit card format is correct")
        if Validators.isSimpleCreditCard("1111111111111111") {
            isSimpleCreditCard.fulfill()
        } else {
            XCTFail("isSimpleCreditCard failed")
        }
        waitForExpectations(timeout: 1)
    }
    func  testIsSimplePassword() throws {
        let isSimplePassword = expectation(description: "The password format is correct")
        if Validators.isSimplePassword("ivanIvanov@!awdw1") {
            isSimplePassword.fulfill()
        } else {
            XCTFail("isSimplePassword failed")
        }
        waitForExpectations(timeout: 10)
    }
    func testFailedIsFilledLogIn() throws {
        let isFilledLogIn = expectation(description: "username or password are empty")
        if Validators.isFilledLogIn(login: "", password: "") {
            XCTFail("FailedtestIsFilledLogIn failed")
        } else {
            isFilledLogIn.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    func testFailedIsFilledRegister() throws {
        let isFilledRegister = expectation(description: "Sign up data are empty")
        if  Validators.isFilledRegister(userName: "Somebody",
                                        email: "",
                                        password: "mypassword",
                                        confirmPassword: "mypassword",
                                        gender: "m",
                                        creditCard: "credit_card",
                                        bio: "") {
            XCTFail("FailedisFilledRegister failed")
        } else {
            isFilledRegister.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    func testFailedIsSimpleEmail() throws {
        let isSimpleEmail = expectation(description: "The email format is incorrect")
        if Validators.isSimpleEmail("some") {
            XCTFail("FailedisSimpleEmail failed")
        } else {
            isSimpleEmail.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    func testFailedIsSimpleCreditCard() throws {
        let isSimpleCreditCard = expectation(description: "The credit card format is incorrect")
        if Validators.isSimpleCreditCard("123") {
            XCTFail("FailedisSimpleCreditCard failed")
        } else {
            isSimpleCreditCard.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    func  testFailedIsSimplePassword() throws {
        let isSimplePassword = expectation(description: "The password format is incorrect")
        if Validators.isSimplePassword("ivan1") {
            XCTFail("FailedisSimplePassword failed")
        } else {
            isSimplePassword.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
}
