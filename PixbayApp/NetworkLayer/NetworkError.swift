//
//  NetworkError.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct NetworkError: Error {
    let message: String
    let statusCode: Int?
    var errorType: NetworkErrorType {
        switch statusCode {
        case ErrorCode.badRequest.rawValue:
            return .badRequest
        case ErrorCode.unauthorized.rawValue:
            return .unauthorized
        case ErrorCode.notFound.rawValue:
            return .notFound
        default:
            return .other
        }
    }

    init(statusCode: Int? = nil, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
}
