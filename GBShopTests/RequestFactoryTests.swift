//
//  RequestFactoryTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RequestFactoryTests: XCTestCase {

    func testLogIn() throws {
        let requestFactory = RequestFactory()
        let auth = requestFactory.makeAuthRequestFatory()

        let signedIn = expectation(description: "logIn")
        auth.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.user.idUser, 123)
                signedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testRegistration() throws {
        let requestFactory = RequestFactory()
        let register = requestFactory.makeRegistrationRequestFatory()

        let signedIn = expectation(description: "logIn")
        register.registration(idUser: 123,
                              userName: "Somebody",
                              password: "mypassword",
                              email: "some@some.ru",
                              gender: "m",
                              creditCard: "credit_card",
                              bio: "This is good! I think I will switch to another language") { (response) in
            switch response.result {
            case .success(let register):
                XCTAssertEqual(register.userMessage, "Регистрация прошла успешно!")
                signedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testLogOut() throws {
        let requestFactory = RequestFactory()
        let logout = requestFactory.makeLogoutRequestFactory()

        let logOut = expectation(description: "log Out")

        logout.logout(idUser: 123) { (response) in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.result, 1)

                logOut.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testChangeUserData() throws {
        let requestFactory = RequestFactory()
        let changeData = requestFactory.makeChangeUserDataRequestFactory()
        let changeExp = expectation(description: "Change Data")

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
                changeExp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testgetCatalog() throws {
        let requestFactory = RequestFactory()
        let catalog = requestFactory.makeCatalogRequestFactory()
        let getCatalog = expectation(description: "get catalog")

        catalog.getCatalog(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let catalog):
                XCTAssertEqual(catalog.products.count, 2)
                getCatalog.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetProductFromCatalog() throws {
        let requestFactory = RequestFactory()
        let prod = requestFactory.makeProductFromCatalogRequestFactory()
        let getProd = expectation(description: "get Prod")

        prod.getProduct(idProduct: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTAssertEqual(prod.result, 1)
                XCTAssertEqual(prod.productName, "Ноутбук")
                XCTAssertEqual(prod.productPrice, 45600)
                XCTAssertEqual(prod.productDescription, "Мощный игровой ноутбук")
                getProd.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testAddReview() throws {
        let requestFactory = RequestFactory()
        let addrev = requestFactory.makeAddReviewRequestFactory()
        let getaddRev = expectation(description: "Review added")

        addrev.addReview(idUser: 123, text: "Текст отзыва") { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                XCTAssertEqual(rev.userMessage, "Ваш отзыв был передан на модерацию")
                getaddRev.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testRemoveReview() throws {
        let requestFactory = RequestFactory()
        let removeRev = requestFactory.makeRemoveReviewRequestFactory()
        let getremovedRev = expectation(description: "Review remved")

        removeRev.removeReview(idComment: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                getremovedRev.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testgetReviewList() throws {
        let requestFactory = RequestFactory()
        let revList = requestFactory.makeReviewListRequestFactory()
        let gotReviewList = expectation(description: "Got Review List")

        revList.getReviewList(idProduct: 123) { (response) in
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
    func testPayBasket() throws {
        let requestFactory = RequestFactory()
        let revList = requestFactory.makePayBasketRequestFactory()
        let gotReviewList = expectation(description: "Got Review List")

        revList.payBasket(idUser: 123, paymentAmount: 200) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    func testAddToBasket() throws {
        let requestFactory = RequestFactory()
        let revList = requestFactory.makeAddToBasketRequestFactory()
        let gotReviewList = expectation(description: "Add To Basket")

        revList.addToBasket(idProduct: 123, quantity: 1) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    func testDeleteFromBasket() throws {
        let requestFactory = RequestFactory()
        let revList = requestFactory.makeDeleteFromBasketRequestFactory()
        let gotReviewList = expectation(description: "Got Review List")

        revList.deleteFromBasket(idProduct: 123) { (response) in
            switch response.result {
            case .success(let rev):
                XCTAssertEqual(rev.result, 1)
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
