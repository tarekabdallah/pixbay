//
//  UITextField+Style.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UITextField {
    func applyStyle(textColor: UIColor = .primary,
                    backgroundColor: UIColor = .clear,
                    font: Fonts.FontName,
                    size: Fonts.FontSize) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = Fonts.font(name: font, size: size)
    }

    func setPlaceholder(text: String?, alignment: NSTextAlignment = .natural) {
        guard let text = text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.purple.withAlphaComponent(0.5),
            NSAttributedString.Key.font: font ?? Fonts.font(name: .light, size: .default),
            NSAttributedString.Key.paragraphStyle: paragraphStyle]
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: attributes)
    }
}
