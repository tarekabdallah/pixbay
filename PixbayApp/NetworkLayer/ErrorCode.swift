//
//  ErrorCode.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum ErrorCode: Int {
    case `internal` = -1
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
}
