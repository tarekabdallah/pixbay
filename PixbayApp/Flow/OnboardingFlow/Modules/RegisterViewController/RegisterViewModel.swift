//
//  RegisterViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

class RegisterViewModel {
    typealias Dependencies = HasUserRepository

    let titleText = "register_scene.label.title_text".localized
    let emailPlaceholderText = "onboarding_scene.placeholder.email_text".localized
    let passwordPlaceholderText = "onboarding_scene.placeholder.password_text".localized
    let agePlaceholderText = "register_scene.placeholder.age_text".localized

    let dependencies: Dependencies
    let disposeBag = DisposeBag()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
