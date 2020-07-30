//
//  String+Validator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

extension String: Validator {
    func isValid(_ validationType: ValidationType) -> Bool {
        switch validationType {
        case .email:
            return isValidEmail
        case .emailOrEmpty:
            return isValidEmail || isEmpty
        case .notEmpty:
            return !isEmpty
        case .password:
            return isValidPassowrd
        case .passwordOrEmpty:
            return isValidPassowrd || isEmpty
        }
    }

    private var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let email = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: self)
    }

    private var isValidPassowrd: Bool {
        return count >= Constants.passwordMinCharacters && count
            <= Constants.passwordMaxCharacters
    }

}
