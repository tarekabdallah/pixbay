//
//  DisplaysAlert.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol DisplaysAlerts {
    typealias Seconds = Double
    func showAlert(title: String?, message: String?, duration: Seconds)
}

extension DisplaysAlerts where Self: UIViewController {
    func showAlert(title: String? = nil, message: String?, duration: Seconds = 3) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let attributedString = NSAttributedString(string: message ?? "", attributes: [
                .foregroundColor: UIColor.primary,
                .font: Fonts.font(name: .medium, size: .default)
            ])
            alert.setValue(attributedString, forKey: "attributedMessage")

            if title != nil {
                let attributedTitleString = NSAttributedString(string: title!, attributes: [
                    .foregroundColor: UIColor.primary,
                    .font: Fonts.font(name: .medium, size: .title)
                ])
                alert.setValue(attributedTitleString, forKey: "attributedTitle")
            }

            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                alert.dismiss(animated: true)
            }
        }
    }
}
