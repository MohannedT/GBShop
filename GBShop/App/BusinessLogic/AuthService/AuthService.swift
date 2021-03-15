//
//  AuthService.swift
//  GBShop
//
//  Created by Александр Ипатов on 13.03.2021.
//

import UIKit

class AuthService {
    static let shared = AuthService()
    private let requestFactory = RequestFactory()

    func login(userName: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userName = userName, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        guard Validators.isFilledLogIn(login: userName, password: password)
        else {  completion(.failure(AuthError.notFilled))
            return
        }
        guard Validators.isSimplePassword(password)
        else {
            completion(.failure(AuthError.invalidPassword))
            return
        }
        requestFactory.makeAuthRequestFatory().login(userName: userName,
                                                     password: password) {(response) in
            switch response.result {
            case .success(let loginResult):
                completion(.success(loginResult.user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func register(userName: String?,
                  password: String?,
                  email: String?,
                  conconfirmPassword: String?,
                  gender: String?,
                  creditCard: String?,
                  bio: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userName = userName,
              let password = password,
              let email = email,
              let conconfirmPassword = conconfirmPassword,
              let creditCard = creditCard,
              let gender = gender,
              let bio = bio
        else {
            completion(.failure(AuthError.unknownError))
            return
        }
        guard Validators.isFilledRegister(userName: userName,
                                          email:  email,
                                          password: password,
                                          confirmPassword: conconfirmPassword,
                                          gender: gender,
                                          creditCard: creditCard,
                                          bio: bio) else {
            completion(.failure(AuthError.notFilled))
            return}
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        guard Validators.isSimplePassword(password)
        else { completion(.failure(AuthError.invalidPassword))
            return}
        guard password == conconfirmPassword else {completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        guard Validators.isSimpleCreditCard(creditCard)
        else { completion(.failure(AuthError.invalidCreditCard))
            return}
        let idUser = Int.random(in: 1...199)
        requestFactory.makeRegistrationRequestFatory().registration(idUser: idUser,
                                                                    userName: userName,
                                                                    password: password,
                                                                    email: email,
                                                                    gender: gender,
                                                                    creditCard: creditCard,
                                                                    bio: bio) {(response) in
            switch response.result {
            case .success:
                let newUser = User(idUser: idUser,
                                          username: userName,
                                          email: email,
                                          gender: gender,
                                          creditCard: creditCard,
                                          bio: bio)
                completion(.success(newUser))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func changeUserData(idUser: Int,
                        userName: String?,
                        password: String?,
                        email: String?,
                        conconfirmPassword: String?,
                        gender: String?,
                        creditCard: String?,
                        bio: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userName = userName,
              let password = password,
              let email = email,
              let conconfirmPassword = conconfirmPassword,
              let creditCard = creditCard,
              let gender = gender,
              let bio = bio
        else {
            completion(.failure(AuthError.unknownError))
            return
        }
        guard Validators.isFilledRegister(userName: userName,
                                          email:  email,
                                          password: password,
                                          confirmPassword: conconfirmPassword,
                                          gender: gender,
                                          creditCard: creditCard,
                                          bio: bio) else {
            completion(.failure(AuthError.notFilled))
            return}
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        guard Validators.isSimplePassword(password)
        else { completion(.failure(AuthError.invalidPassword))
            return}
        guard password == conconfirmPassword else {completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        guard Validators.isSimpleCreditCard(creditCard)
        else { completion(.failure(AuthError.invalidCreditCard))
            return}
        requestFactory.makeChangeUserDataRequestFactory().changeUserData(idUser: idUser,
                                                                         userName: userName,
                                                                         password: password,
                                                                         email: email,
                                                                         gender: gender,
                                                                         creditCard: creditCard,
                                                                         bio: bio) {(response) in
            switch response.result {
            case .success:
                let changedUser = User(idUser: idUser,
                                          username: userName,
                                          email: email,
                                          gender: gender,
                                          creditCard: creditCard,
                                          bio: bio)
                completion(.success(changedUser))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
