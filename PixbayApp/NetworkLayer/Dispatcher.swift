//
//  Dispatcher.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

/// Implement this protocol and use the implemting class to execute all network calls
protocol Dispatcher {
    init(environment: Environment, logger: NetworkLoggerType)

    func execute(request: Request) throws -> Single<Response>
}
