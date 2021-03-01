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
                XCTAssertEqual(login.user.id, 123)
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
        register.registration(idUser: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "credit_card", bio: "This is good! I think I will switch to another language") { (response) in
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
        
        
        changeData.changeUserData(idUser: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "credit_card", bio: "This is good! I think I will switch to another language") { (response) in
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
                XCTAssertEqual(catalog.count, 2)
                getCatalog.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
