//
//  Request.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

protocol Request {
    var path: String { get }
    var parameters: RequestParameters { get }
    var headers: [HTTPHeaderName: String]? { get }
    var method: HTTPMethod { get }
}

extension Request {
    var method: HTTPMethod {
        return .get
    }

    var headers: [HTTPHeaderName: String]? {
        return nil
    }

    var parameters: RequestParameters {
        return .query(nil)
    }
}
