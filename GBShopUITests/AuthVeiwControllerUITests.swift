//
//  AuthVeiwControllerUITests.swift
//  GBShopUITests
//
//  Created by Александр Ипатов on 25.03.2021.
//

import XCTest

class AuthVeiwControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()

    }

    override func tearDownWithError() throws {
    }

    func testLogin() throws {
  let app = XCUIApplication()
        app.launch()
        let authView = app.otherElements["authView"].firstMatch
        XCTAssertTrue(authView.waitForExistence(timeout: 5))

        let userNameTextField = authView.textFields["userNameTextField"]
        userNameTextField.tap()
        userNameTextField.typeText("user")
        let passwordTextField = authView.secureTextFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("qwerty@!@IK123")

        let loginButton = app.buttons["loginButton"].firstMatch
        XCTAssertTrue(loginButton.isHittable, "\(app.debugDescription)")
        loginButton.tap()
        app.alerts["Welcome!"].scrollViews.otherElements.buttons["OK"].tap()
    }
}
