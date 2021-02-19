//
//  RequestFactory.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
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
        return Registration(errorParser: errorParser, sessionManager: commonSession, baseURL: baseUrl, queue: sessionQueue)
        
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser, sessionManager: commonSession, baseURL: baseUrl, queue: sessionQueue)
    }
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
            let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser, sessionManager: commonSession, baseURL: baseUrl, queue: sessionQueue)
        
    }
    func makeCatalogRequestFactory() -> CatalogDataRequestFactory {
            let errorParser = makeErrorParser()
        return CatalogData(errorParser: errorParser, sessionManager: commonSession, baseURL: baseUrl, queue: sessionQueue)
        
    }
}
