//
//  NetfoxService.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import netfox

class NetfoxService {
    static func initialise() {
        if AppEnvironment.isDevelopTarget {
            NFX.sharedInstance().start()
        }
    }
}
