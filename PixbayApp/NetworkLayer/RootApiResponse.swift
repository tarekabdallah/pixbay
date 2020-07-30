//
//  RootApiResponse.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class RootApiResponse<T: Decodable>: Decodable {
    var success: Bool!
    var message: String?
    var data: T?
}
