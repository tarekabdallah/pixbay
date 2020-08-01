//
//  UIView+Loader.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIView {
    func showLoader(backgroundColor: UIColor? = nil,
                    loaderColor: UIColor? = nil,
                    ball: Bool = false) {
        let hasLoaderHUD = subviews.contains { $0 is Loader }
        guard !hasLoaderHUD else { return }

        let loader = Loader(frame: bounds,
                            backgroundColor: backgroundColor ?? self.backgroundColor,
                            loaderColor: loaderColor,
                            type: ball ? .ballPulse : nil)
        loader.cornerRadius = cornerRadius
        loader.clipsToBounds = true
        loader.layer.zPosition = .greatestFiniteMagnitude
        loader.startAnimating()
        isUserInteractionEnabled = false
        addSubview(loader)
    }

    func hideLoader() {
        let loaders = subviews.filter { $0 is Loader }

        loaders.forEach { $0.removeFromSuperview() }
        isUserInteractionEnabled = true
    }
}
