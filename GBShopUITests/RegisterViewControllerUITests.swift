//
//  RegisterViewControllerUITests.swift
//  GBShopUITests
//
//  Created by Александр Ипатов on 25.03.2021.
//

import XCTest

class RegisterViewControllerUITests: XCTestCase {
    func testBackToLogin() throws {
        let app = XCUIApplication()
        app.launch()
        let goToSignUpButton = app.buttons["signUpButton"].firstMatch
        XCTAssertTrue(goToSignUpButton.isHittable, "\(app.debugDescription)")
        goToSignUpButton.tap()
        let backToLoginButton = app.buttons["Already have an account"].firstMatch
        XCTAssertTrue(backToLoginButton.isHittable, "\(app.debugDescription)")
        backToLoginButton.tap()
    }

    func testSignUp() throws {
        let app = XCUIApplication()
        app.launch()
        let goToSignUpButton = app.buttons["signUpButton"].firstMatch
        XCTAssertTrue(goToSignUpButton.isHittable, "\(app.debugDescription)")
        goToSignUpButton.tap()
        let registerView = app.otherElements["registerView"].firstMatch
        XCTAssertTrue(registerView.waitForExistence(timeout: 1))
        let scrollView = app.scrollViews["scrollView"]
        let userNameTextField = scrollView.textFields["Username"]
        userNameTextField.tap()
        userNameTextField.typeText("user")
        let emailTextField = scrollView.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("userEmail@mail.com")
        let passwordTextField = scrollView.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("qwetrty@!23W")
        let confirmPasswordTextField = scrollView.secureTextFields["Confirm password"]
        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText("qwetrty@!23W")
        scrollView.otherElements.buttons["Male"].tap()
        let creditCardTextField = scrollView.secureTextFields["Credit card"]
        creditCardTextField.tap()
        creditCardTextField.typeText("1111111111111111")
        let bioTextField = scrollView.textFields["Hy! I want to buy something"]
        bioTextField.tap()
        bioTextField.typeText("Hy! I want to buy something")
        scrollView.swipeUp()
        scrollView.tap()
        let signUpButton = app.buttons["Sign Up"].firstMatch
        XCTAssertTrue(signUpButton.isHittable, "\(app.debugDescription)")
        signUpButton.tap()
        app.alerts["Welcome!"].scrollViews.otherElements.buttons["OK"].tap()

    }
}
