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

class OnboardingViewController: UIViewController, DisplaysAlerts {

    @IBOutlet private weak var loginButton: ActionButton!
    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var registerButton: UIButton!

    var viewModel: OnboardingViewModel!
    var onRegisterButtonTapped: (() -> Void)?
    var loggedInSuccessfully: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
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
        emailTextField.errorHint = viewModel.emailValidationText
        passwordTextField.errorHint = viewModel.passwordValidationText

        setupLoginButtonBottomConstraint()
        setupRxButtons()
        setupRxTextFields()
    }

    func setupRxTextFields() {
        emailTextField.rx.validate(.email).subscribe { [weak self] _ in
            self?.enableButtonIfPossible()
        }.disposed(by: viewModel.disposeBag)
        passwordTextField.rx.validate(.password).subscribe { [weak self] _ in
            self?.enableButtonIfPossible()
        }.disposed(by: viewModel.disposeBag)
    }

    func setupRxButtons() {
        registerButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [unowned self] in
                self.onRegisterButtonTapped?()
                }, onCompleted: nil).disposed(by: viewModel.disposeBag)

        loginButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [unowned self] in
                self.login()
                }, onCompleted: nil).disposed(by: viewModel.disposeBag)
    }

    func enableButtonIfPossible() {
        guard !emailTextField.hasError,
            !passwordTextField.hasError,
            !(emailTextField.text?.isEmpty ?? true),
            !(passwordTextField.text?.isEmpty ?? true) else {
                loginButton.applyStyle(textColor: .white,
                                       backgroundColor: .gray,
                                       font: .book,
                                       textSize: .default)
                loginButton.isUserInteractionEnabled = false
                return
        }
        loginButton.applyStyle(textColor: .primary,
                               backgroundColor: .white,
                               font: .medium,
                               textSize: .default)
        loginButton.isUserInteractionEnabled = true
    }

    func login() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }

        viewModel.login(email: email, password: password).subscribe(onSuccess: { [weak self] in
            self?.loggedInSuccessfully?()
            }, onError: { [weak self] error in
                self?.showAlert(message: (error as NSError).domain)
        }).disposed(by: viewModel.disposeBag)
    }

    func setupLoginButtonBottomConstraint() {
        let bottomConstraint = loginButton
            .bottomAnchor
            .constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -32)
        bottomConstraint.isActive = true
        bottomConstraint.priority = .init(rawValue: 750)
    }
}
