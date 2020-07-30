//
//  DependencyProvider.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class DependencyProvider: HasPixbayAppApi {
    var pixbayAppApi: PixbayAppApi

    init() {
        let environment = ProductionEnvironment()
        let networkDispatcher = NetworkDispatcher(environment: environment,
                                                  logger: NetworkLogger())
        pixbayAppApi = PixbayAppApi(dispatcher: networkDispatcher)
    }
}
