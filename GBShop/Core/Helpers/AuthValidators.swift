//
//  RegisterValidators.swift
//  GBShop
//
//  Created by Александр Ипатов on 12.03.2021.
//

import Foundation

class Validators {
    static func isFilledLogIn(login: String?, password: String?) -> Bool {
        guard let password = password,
              let login = login,
              password != "",
              login != "" else {
            return false
        }
        return true
    }
    static func isFilledRegister(userName: String?,
                                 email: String?,
                                 password: String?,
                                 confirmPassword: String?,
                                 gender: String?,
                                 creditCard: String?,
                                 bio: String?) -> Bool {
        guard let userName = userName,
              let password = password,
              let confirmPassword = confirmPassword,
              let gender = gender,
              let creditCard = creditCard,
              let bio = bio,
              userName != "",
              password != "",
              confirmPassword != "",
              gender != " ",
              creditCard != "",
              bio != ""
        else {
            return false
        }
        return true
    }

    static func isSimpleEmail(_ email: String?) -> Bool {
        let emailRegex = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegex)
    }

    static func isSimplePassword(_ password: String?) -> Bool {
        let passwordregex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$"
        return check(text: password, regEx: passwordregex)
    }
    static func isSimpleCreditCard(_ creditCard: String?) -> Bool {
        let creditCardregex = "^(?=.*[0-9]).{16}$"
        return check(text: creditCard, regEx: creditCardregex)
    }
    private static func check(text: String?, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
