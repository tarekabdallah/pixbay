//
//  UIViewController+KeyboardAvoidance.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if !didTouchInside(viewType: UITextField.self, fromView: view, gesture: sender),
            !didTouchInside(viewType: UIButton.self, fromView: view, gesture: sender) {
            view.endEditing(true)
        }
    }

    static func swizzleViewDidLoad() {
        if self != UIViewController.self {
            return
        }
        let _: () = {
            let originalSelector = #selector(UIViewController.viewDidLoad)
            let swizzeledViewDidLoadSelector = #selector(UIViewController.swizzeledViewDidLoad)
            let originalFunction = class_getInstanceMethod(self, originalSelector)
            let swizzeledViewDidLoadFunction = class_getInstanceMethod(self, swizzeledViewDidLoadSelector)
            method_exchangeImplementations(originalFunction!, swizzeledViewDidLoadFunction!)
        }()
    }
}

private extension UIViewController {
    @objc
    func swizzeledViewDidLoad() {
        self.swizzeledViewDidLoad()

        hideKeyboardWhenTappedAround()
    }

    func didTouchInside<T: UIView>(viewType: T.Type,
                                   fromView currentView: UIView,
                                   gesture: UITapGestureRecognizer) -> Bool {
        var returnValue = false
        for subview in currentView.subviews {
            if subview is T, gesture.isTouchInside(subview) {
                return true
            } else {
                returnValue = returnValue || didTouchInside(viewType: viewType, fromView: subview, gesture: gesture)
            }
        }
        return returnValue
    }
}
