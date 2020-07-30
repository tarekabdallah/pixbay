//
//  ActionButton.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension ActionButton {
    func configureViews() {
        self.applyStyle(textColor: .primary,
                        backgroundColor: .white,
                        font: .medium,
                        textSize: .default)
        self.dropShadow()
    }
}
