//
//  UIButton+Style.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIButton {
    func applyStyle(textColor: UIColor = .white,
                    backgroundColor: UIColor = .primary,
                    font: Fonts.FontName,
                    textSize: Fonts.FontSize,
                    cornerRadius: CGFloat = 10) {
        self.cornerRadius = cornerRadius
        setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        titleLabel?.font = Fonts.font(name: font, size: textSize)
    }

    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }
}
