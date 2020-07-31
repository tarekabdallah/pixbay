//
//  UserRepositoryType.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol UserRepositoryType {
    func create(user: User)
    func get(with email: String) -> User?
}
