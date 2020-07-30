//
//  OnboardingViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

class OnboardingViewModel {
    typealias Dependencies = HasPixbayAppApi

    let loginButtonText = "onboarding_scene.button.login_text".localized
    let emailPlaceholderText = "onboarding_scene.placeholder.email_text".localized
    let passwordPlaceholderText = "onboarding_scene.placeholder.password_text".localized
    let registerButtonText = "onboarding_scene.button.register_text".localized

    let dependencies: Dependencies
    let disposeBag = DisposeBag()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
