//
//  Presentable.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController
}

extension Presentable where Self: UIViewController {
    func toPresent () -> UIViewController {
        return self
    }
}
