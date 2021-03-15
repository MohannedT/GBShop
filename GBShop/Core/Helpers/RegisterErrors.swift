//
//  RegisterErrors.swift
//  GBShop
//
//  Created by Александр Ипатов on 12.03.2021.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case invalidPassword
    case passwordsNotMatched
    case unknownError
    case invalidCreditCard
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Empty fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("The mail format is not valid", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Passwords don't match", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .invalidPassword:
            return NSLocalizedString("""
Your password must contain:
One or more digit
One or more lower case letter
One or more uppercase letter
One or more special symbol
Eight or more characters
""", comment: "")
        case .invalidCreditCard:
            return NSLocalizedString("Credit card format is not valid", comment: "")
        }
    }
}
