//
//  IconLabel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class IconLabel: UILabel {
    override var text: String? {
        didSet {
            hanldeIcon()
        }
    }

    var icon: UIImage? {
        didSet {
            hanldeIcon()
        }
    }
}

// MARK: - Private Helper Mehtods
private extension IconLabel {
    func hanldeIcon() {
        guard let icon = icon else {
            attributedText = nil
            return
        }

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = icon
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0,
                                        y: imageOffsetY,
                                        width: bounds.height,
                                        height: bounds.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " \(text ?? "")" )
        completeText.append(textAfterIcon)
        attributedText = completeText
    }
}
