//
//  String+Localization.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }

    func localizedWithLocale(with arguments: CVarArg...) -> String {
        return String(format: self.localized, locale: Locale.current, arguments: arguments)
    }
}
