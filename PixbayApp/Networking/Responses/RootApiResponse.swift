//
//  RootApiResponse.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct RootApiResponse<T: Decodable>: Decodable {
    let total: Int
    let totalHits: Int
    let hits: T?
}
