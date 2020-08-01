//
//  UserSettings.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class UserSettings {
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let user = "pixbayapp.user_settings.user"
    }

    var user: User? {
        get {
            guard let userData = defaults.data(forKey: Keys.user),
                let savedUser = try? JSONDecoder().decode(User.self, from: userData) else { return nil }

            return savedUser
        } set {
            let encoder = JSONEncoder()
            if let encodedUser = try? encoder.encode(newValue) {
                defaults.set(encodedUser, forKey: Keys.user)
                defaults.synchronize()
            }
        }
    }

    var isLoggedIn: Bool {
        return user != nil
    }

    func clear() {
        defaults.removeObject(forKey: Keys.user)
        defaults.synchronize()
    }

    func setUser(_ user: User) {
        self.user = user
    }
}
