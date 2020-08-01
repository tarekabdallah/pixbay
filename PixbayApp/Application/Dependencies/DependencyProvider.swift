//
//  DependencyProvider.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class DependencyProvider: HasPixbayAppApi, HasUserRepository, HasUserSettings {
    var pixbayAppApi: PixbayAppApi
    var userRepository: UserRepositoryType
    var userSettings: UserSettings

    init() {
        let environment = ProductionEnvironment()
        let networkDispatcher = NetworkDispatcher(environment: environment,
                                                  logger: NetworkLogger())
        pixbayAppApi = PixbayAppApi(dispatcher: networkDispatcher)
        userRepository = UserRepository()
        userSettings = UserSettings()
    }
}
