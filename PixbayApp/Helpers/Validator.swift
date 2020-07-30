//
//  Validator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol Validator {
    func isValid(_ validationType: ValidationType) -> Bool
}
