//
//  ProductFromCatalogTests.swift
//  GBShopTests
//
//  Created by Александр Ипатов on 01.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductFromCatalogTests: XCTestCase {

    func testproductFromCatalog() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://calm-basin-71582.herokuapp.com"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let prod = ProductFromCatalog(errorParser: ErrorParser(),
                                      sessionManager: session,
                                      baseURL: baseUrl,
                                      queue: DispatchQueue.global(qos: .utility))

        let gotProd = expectation(description: "Got Prod")

        prod.getProduct(idProduct: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTAssertEqual(prod.result, 1)
                XCTAssertEqual(prod.productName, "Ноутбук APPLE MacBook Pro M1 13.3, IPS, Apple M1 8ГБ, 256ГБ SSD, Mac OS, MYDA2RU/A, серебристый")
                XCTAssertEqual(prod.productPrice, 45600)
                   XCTAssertEqual(prod.productDescription, """
Невероятно производительным и надежным персональным устройством является ноутбук APPLE MacBook Pro 13.3". Эта модель оснащена восьмиядерным процессором Apple M1, который гарантирует эффективное решение повседневных, офисных и мультимедийных задач, а также стабильное функционирование системы при максимальных нагрузках. Мгновенный отклик системы на ваши действия обеспечивают 8 Гб оперативной памяти. 13,3-дюймовый дисплей IPS с тонкими рамками и высоким разрешением обеспечивает широкие углы обзора и яркое, насыщенное изображение. Ноутбук APPLE MacBook Pro 13.3" обладает твердотельным накопителем на 256 Гб. Два разъема Thunderbolt 3 способствуют максимально комфортному и скоростному подключению периферии. Быструю авторизацию гарантирует сканер отпечатка пальца.
""")
                gotProd.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailedProductFromCatalog() throws {

        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        let prod = ProductFromCatalog(errorParser: ErrorParser(),
                                      sessionManager: session,
                                      baseURL: baseUrl,
                                      queue: DispatchQueue.global(qos: .utility))
        let failedgetProf = expectation(description: "failed get prod")

        prod.getProduct(idProduct: 123) { (response) in
            switch response.result {
            case .success(let prod):
                XCTFail("must have failed: \(prod)")
            case .failure:
                failedgetProf.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
