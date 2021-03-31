//
//  RequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {

    let baseUrl = URL(string: "https://calm-basin-71582.herokuapp.com/")!
  // let baseUrl = URL(string: "http://127.0.0.1:8080")!

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, baseURL: baseUrl, queue: sessionQueue)
    }

    func makeRegistrationRequestFatory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser,
                            sessionManager: commonSession,
                            baseURL: baseUrl,
                            queue: sessionQueue)

    }

    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser,
                              sessionManager: commonSession,
                              baseURL: baseUrl,
                              queue: sessionQueue)
    }
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
            let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)

    }
    func makeCatalogRequestFactory() -> CatalogDataRequestFactory {
            let errorParser = makeErrorParser()
        return CatalogData(errorParser: errorParser,
                           sessionManager: commonSession,
                           baseURL: baseUrl,
                           queue: sessionQueue)

    }

    func makeProductFromCatalogRequestFactory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
    return ProductFromCatalog(errorParser: errorParser,
                              sessionManager: commonSession,
                              baseURL: baseUrl,
                              queue: sessionQueue)
    }

    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
    return AddReview(errorParser: errorParser,
                     sessionManager: commonSession,
                     baseURL: baseUrl,
                     queue: sessionQueue)
    }

    func makeRemoveReviewRequestFactory() -> RemoveReviewRequestFactory {
        let errorParser = makeErrorParser()
    return RemoveReview(errorParser: errorParser,
                        sessionManager: commonSession,
                        baseURL: baseUrl,
                        queue: sessionQueue)
    }
    func makeReviewListRequestFactory() -> ReviewListRequestFactory {
        let errorParser = makeErrorParser()
    return ReviewList(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)
    }
    func makePayBasketRequestFactory() -> PayBasketRequestFactory {
        let errorParser = makeErrorParser()
    return PayBasket(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)
    }
    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParser = makeErrorParser()
    return  DeleteFromBasket(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)
    }
    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParser = makeErrorParser()
    return AddToBasket(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)
    }
    func makeGetBasketRequestFactory() -> GetBasketREqestFactory {
        let errorParser = makeErrorParser()
    return GetBasket(errorParser: errorParser,
                      sessionManager: commonSession,
                      baseURL: baseUrl,
                      queue: sessionQueue)
    }
}
