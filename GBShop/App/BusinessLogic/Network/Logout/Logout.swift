//
//  Logout.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.02.2021.
//

import Foundation
import Alamofire

class Logout: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        baseURL: URL,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.baseUrl = baseURL
        self.queue = queue
    }
}

extension Logout: LogoutRequestFactory {
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
       let requestModel = LogoutUser(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
  
    }
   



extension Logout {
    struct LogoutUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        
        let idUser: Int
        var parameters: Parameters? {
            return [
                "id_user" : idUser,
               
            ]
        }
    }
}
