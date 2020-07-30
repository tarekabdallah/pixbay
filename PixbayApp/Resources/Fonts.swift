//
//  Font.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

import UIKit

struct Fonts {
    enum FontName: String {
        case light = "Gotham-Light"
        case medium = "Gotham-Medium"
        case book = "Gotham-Book"
        case bold = "Gotham-Bold"
    }

    enum FontSize: CGFloat {
        case details = 12
        case `default` = 15
        case title = 20
        case largeTitle = 40
    }

    static func font(name: FontName, size: FontSize) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size.rawValue)
        guard let returnFont = font else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
        return returnFont
    }
}
