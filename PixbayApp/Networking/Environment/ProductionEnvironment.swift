//
//  ProductionEnvironment.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class ProductionEnvironment: BaseEnvironment {
    override var name: String {
        "Production"
    }

    override var host: String {
        "https://pixabay.com/api"
    }

    override var apiKey: String {
        "17716069-d692763fa430726c3faa15f7c"
    }
}
