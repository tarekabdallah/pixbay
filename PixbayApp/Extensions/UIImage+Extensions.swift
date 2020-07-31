//
//  UIImage+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String?, placeHolder: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeHolder
            return
        }
        kf.setImage(with: url, placeholder: placeHolder)
    }
}
