//
//  UILabel+Style.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UILabel {
    func applyStyle(textColor: UIColor = .primary,
                    backgroundColor: UIColor = .clear,
                    font: Fonts.FontName,
                    size: Fonts.FontSize) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = Fonts.font(name: font, size: size)
    }
}
