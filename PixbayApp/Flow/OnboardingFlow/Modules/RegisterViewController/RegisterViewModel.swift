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
    typealias Dependencies = HasUserRepository & HasUserSettings

    let titleText = "register_scene.label.title_text".localized
    let emailPlaceholderText = "onboarding_scene.placeholder.email_text".localized
    let passwordPlaceholderText = "onboarding_scene.placeholder.password_text".localized
    let agePlaceholderText = "register_scene.placeholder.age_text".localized
    let emailValidationText = "onboarding_scene.validation.fill_email_text".localized
    let passwordValidationText = "onboarding_scene.validation.fill_password_text".localized
    let accountExistAlertText = "register_scene.alert.email_exists_text".localized

    let dependencies: Dependencies
    let disposeBag = DisposeBag()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createUser(email: String, password: String, age: String) -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard self?.dependencies.userRepository.get(with: email) == nil else {
                let error = NSError(domain: self?.accountExistAlertText ?? "",
                                    code: ErrorCode.internal.rawValue,
                                    userInfo: nil)
                single(.error(error))
                return Disposables.create()
            }

            let user = User(email: email, password: password, age: age)
            self?.dependencies.userRepository.create(user: user)
            self?.dependencies.userSettings.setUser(user)

            single(.success(Void()))
            return Disposables.create()
        }
    }
}
