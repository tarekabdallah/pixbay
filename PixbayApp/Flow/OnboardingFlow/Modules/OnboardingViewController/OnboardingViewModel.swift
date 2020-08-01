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
    typealias Dependencies = HasUserRepository & HasUserSettings

    let loginButtonText = "onboarding_scene.button.login_text".localized
    let emailPlaceholderText = "onboarding_scene.placeholder.email_text".localized
    let passwordPlaceholderText = "onboarding_scene.placeholder.password_text".localized
    let registerButtonText = "onboarding_scene.button.register_text".localized
    let errorAlertText = "onboarding_scene.alert.check_email_password_text".localized
    let emailValidationText = "onboarding_scene.validation.fill_email_text".localized
    let passwordValidationText = "onboarding_scene.validation.fill_password_text".localized
    let dependencies: Dependencies
    let disposeBag = DisposeBag()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func login(email: String, password: String) -> Single<Void> {
        Single<Void>.create { [weak self] single in
            guard let user = self?.dependencies.userRepository.get(with: email),
            user.password == password.sha512() else {
                let error = NSError(domain: self?.errorAlertText ?? "",
                                    code: ErrorCode.internal.rawValue,
                                    userInfo: nil)
                single(.error(error))
                return Disposables.create()
            }
            self?.dependencies.userSettings.setUser(user)
            single(.success(Void()))
            return Disposables.create()
        }
    }
}
