//
//  LogoutTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop


class LogoutTests: XCTestCase {
   
    func testLogOut() throws {
        let baseUrl = try XCTUnwrap (URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let logout = Logout(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))
        
        let loggedOut = expectation(description: "loggedOut")
        
        logout.logout(idUser: 123) { (response) in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.result, 1)
              
                loggedOut.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testFailedLogOut() throws {
        
        let baseUrl = try XCTUnwrap (URL(string: "https://raw.githubusercontent.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let logout = Logout(errorParser: ErrorParser(), sessionManager: session, baseURL: baseUrl, queue: DispatchQueue.global(qos: .utility))
        
        let failedlogout = expectation(description: "failed to log Out")
        
        logout.logout(idUser: 123) { (response) in
            switch response.result {
            case .success(let logout):
                XCTFail("must have failed: \(logout)")
                
               
            case .failure:
                failedlogout.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
