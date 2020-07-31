//
//  KeyboardAdjustableScrollView.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import KeyboardLayoutGuide

class KeyboardAdjustableScrollView: UIScrollView {

    private let notificationCenter = NotificationCenter.default

    override func awakeFromNib() {
        super.awakeFromNib()

        setupNotificationCenter()
        setupBottomConstraint()
    }

    deinit {
        notificationCenter.removeObserver(self)
    }
}

// MARK: - Private Helper Methods
private extension KeyboardAdjustableScrollView {
    func setupBottomConstraint() {
        guard let superview = superview else { return }

        let bottomConstraint = bottomAnchor
            .constraint(equalTo: superview.keyboardLayoutGuide.topAnchor, constant: 0)
        bottomConstraint.isActive = true
        bottomConstraint.priority = .init(rawValue: 750)
    }

    func setupNotificationCenter() {
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    @objc
    func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardScreenEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let view = superview else {
                return
        }

        let keyboardScreenEndFrameCGRect = keyboardScreenEndFrame.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrameCGRect, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            contentInset = UIEdgeInsets.zero

        } else {
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)

        }
        scrollIndicatorInsets = contentInset

        if let activeFieldPresent = findActiveResponder(),
        !bounds.contains(activeFieldPresent.frame) {
            scrollRectToVisible(activeFieldPresent.frame, animated: true)
        }
    }
}
