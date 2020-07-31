//
//  CDUser+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

extension CDUser {
    func convertToUser() -> User {
        return User(email: email, password: password, age: age)
    }
}
