//
//  BaseEnvironment.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class BaseEnvironment: Environment {
    var name: String {
        fatalError("Must be implemented in subclass")
    }

    var host: String {
        fatalError("Must be implemented in subclass")
    }

    var headers: [HTTPHeaderName: String?] {
        return [:]
    }
}
