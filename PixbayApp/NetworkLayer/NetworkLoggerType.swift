//
//  NetworkLoggerType.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol NetworkLoggerType {
    func log(request: URLRequest)
    func log(response: URLResponse, data: Data?, error: Error?)
}
