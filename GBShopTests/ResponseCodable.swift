//
//  ResponseCodable.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class ResponseCodableTests: XCTestCase {

    let expectation = XCTestExpectation(description: "Download https://failUrl")
       var errorParser: ErrorParserStub!

       override func setUp() {
           super.setUp()
           errorParser = ErrorParserStub()
       }

       override func tearDown() {
           super.tearDown()
           errorParser = nil
       }

       func testShouldDownloadAndParse() {
           AF
               .request("https://jsonplaceholder.typicode.com/posts/1")
               .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<PostStub>) in
                   switch response.result {
                   case .success: break
                   case .failure:
                       XCTFail("failed")
                   }
                   self?.expectation.fulfill()
           }
           wait(for: [expectation], timeout: 10.0)
       }

}
