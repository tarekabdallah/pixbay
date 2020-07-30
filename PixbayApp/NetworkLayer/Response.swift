//
//  Response.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum Response {
    case success(_ errorCode: Int?, Data)
    case failure(error: Error)

    init(_ httpURLResponse: HTTPURLResponse?, data: Data?, error: Error?) {
        let successCodes = 200...499

        guard let statusCode = httpURLResponse?.statusCode,
            successCodes.contains(statusCode) else {
                self = .failure(error: error ?? NetworkErrorType.serverFailure)
                return
        }

        guard let data = data else {
            self = .failure(error: NetworkErrorType.noData)
            return
        }

        self = .success(statusCode, data)
    }
}
