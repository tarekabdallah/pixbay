//
//  RequestParameters.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum RequestParameters {
    case body([String: Any?]?)
    case query([String: Any?]?)
    case array([Any]?)
}
