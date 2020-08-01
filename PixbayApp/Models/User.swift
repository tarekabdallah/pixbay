//
//  User.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CryptoSwift

struct User: Codable {
    let email: String?
    let password: String?
    let age: String?

    init(email: String?, password: String?, age: String?) {
        self.email = email
        self.age = age
        self.password = password
    }
}
