//
//  ImageButton.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ImageButton: UIButton {
    @IBInspectable var edgeInsets: CGFloat = 5

    override func awakeFromNib() {
        super.awakeFromNib()

        applyInsets(edge: edgeInsets)
    }

    func applyInsets(edge: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
        self.imageView?.contentMode = .scaleAspectFit
    }
}
