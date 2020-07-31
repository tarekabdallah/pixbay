//
//  Environment.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol Environment {
    var name: String { get }
    var host: String { get }
    var headers: [HTTPHeaderName: String?] { get }
    var apiKey: String { get }
}
