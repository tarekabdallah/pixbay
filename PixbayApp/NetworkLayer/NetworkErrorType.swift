//
//  NetworkErrorType.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum NetworkErrorType: Error {
    case noData
    case unauthorized
    case badRequest
    case notFound
    case serverFailure
    case invalidUrl
    case nonHttpResponse
    case other
    case parsingError
}
