//
//  OnboardingViewController.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import KeyboardLayoutGuide

class OnboardingViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var registerButton: UIButton!

    var viewModel: OnboardingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension OnboardingViewController {
    func configureViews() {
        registerButton.applyStyle(textColor: .white,
                                  font: .book,
                                  textSize: .default)

        loginButton.setTitle(viewModel.loginButtonText)
        emailTextField.placeholder = viewModel.emailPlaceholderText
        passwordTextField.placeholder = viewModel.passwordPlaceholderText
        registerButton.setTitle(viewModel.registerButtonText)

        setupLoginButtonBottomConstraint()
    }

    func setupLoginButtonBottomConstraint() {
        let bottomConstraint = loginButton
            .bottomAnchor
            .constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -32)
        bottomConstraint.isActive = true
        bottomConstraint.priority = .init(rawValue: 750)
    }
}
