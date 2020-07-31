//
//  DropdownStyle.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import DropDown

class DropdownStyle {
    static func initialize() {
        DropDown.appearance().textColor = .purple
        DropDown.appearance().textFont = Fonts.font(name: .bold, size: .details)
        DropDown.appearance().selectionBackgroundColor = UIColor.primary.withAlphaComponent(0.2)
        DropDown.appearance().setupCornerRadius(10)
        DropDown.appearance().backgroundColor = .white
    }
}
