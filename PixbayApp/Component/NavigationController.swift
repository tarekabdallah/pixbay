//
//  NavigationController.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Fonts.font(name: .book,
                                                                                     size: .title),
                                             NSAttributedString.Key.foregroundColor: UIColor.white]
        // Hide Back Button text label without clearing the text color
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
            UIOffset(horizontal: -1000.0,
                     vertical: 0.0), for: .default)

        navigationItem.largeTitleDisplayMode = .always

        // change back icon & set its color
        if let backArrowImage = UIImage(named: "icon-back") {
            let backArrowImageShift: CGFloat = 12
            UIGraphicsBeginImageContextWithOptions(CGSize(width: backArrowImage.size.width + backArrowImageShift,
                                                          height: backArrowImage.size.height),
                                                   false,
                                                   0)
            backArrowImage.draw(at: CGPoint(x: backArrowImageShift, y: 0))
            let finalBackArrowImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            navigationBar.backIndicatorImage = finalBackArrowImage
            navigationBar.backIndicatorTransitionMaskImage = finalBackArrowImage
            navigationBar.tintColor = .white
        }
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .primary
    }
}
