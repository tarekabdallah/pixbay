//
//  UIView+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    func setBorder(borderColor: UIColor, borderWidth: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }

    func applyStyle(backgroundColor: UIColor, cornerRadius: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }

    func dropShadow(color: UIColor = .black, shadowFrame: CGRect? = nil) {
        let cornerRadius = layer.cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowPath = UIBezierPath(roundedRect: shadowFrame ?? bounds,
                                        byRoundingCorners: .allCorners,
                                        cornerRadii: CGSize(width: cornerRadius,
                                                            height: cornerRadius)).cgPath
        layer.shouldRasterize = true
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.rasterizationScale = UIScreen.main.scale
    }

    func removeShadow() {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shouldRasterize = false
        layer.rasterizationScale = 1
    }

    func drawBackground() {
        let backgroundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: .allCorners,
                                      cornerRadii: CGSize(width: cornerRadius,
                                                          height: cornerRadius)).cgPath
        backgroundLayer.path = bezierPath
        backgroundLayer.fillColor = backgroundColor?.cgColor
        backgroundLayer.lineWidth = 1
        backgroundLayer.position = .zero
        backgroundColor = .clear
        layer.insertSublayer(backgroundLayer, at: 0)
    }

    /// Returns the activeResponder inside a view. If none found returns nil
    func findActiveResponder() -> UIView? {
        return findActiveResponder(in: self)
    }
}

// MARK: - Private Helper Methods
private extension UIView {
    func findActiveResponder(in view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        } else {
            for subview in view.subviews {
                if let firstResponder = findActiveResponder(in: subview) {
                    return firstResponder
                }
            }
        }
        return nil
    }
}
