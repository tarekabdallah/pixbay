//
//  RegisterViewController.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class RegisterViewController: UIViewController, DisplaysAlerts {

    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var ageTextField: DropdownTextField!
    @IBOutlet private weak var registerButton: ActionButton!

    var viewModel: RegisterViewModel!
    var registeredSuccessfully: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil, "viewModel must be set")

        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension RegisterViewController {
    func configureViews() {
        title = viewModel.titleText
        registerButton.set(textColor: .white, backgroundColor: .primary)

        emailTextField.placeholder = viewModel.emailPlaceholderText
        passwordTextField.placeholder = viewModel.passwordPlaceholderText
        ageTextField.placeholder = viewModel.agePlaceholderText
        registerButton.setTitle(viewModel.titleText)
        emailTextField.errorHint = viewModel.emailValidationText
        passwordTextField.errorHint = viewModel.passwordValidationText
        ageTextField.configure(with: Array(18...99))
        ageTextField.onItemSelected = { [unowned self] in
            self.enableButtonIfPossible()
        }
        setUpRXButtons()
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

    func enableButtonIfPossible() {
        guard !emailTextField.hasError,
            !passwordTextField.hasError,
            !(emailTextField.text?.isEmpty ?? true),
            !(passwordTextField.text?.isEmpty ?? true),
            !(ageTextField.text?.isEmpty ?? true) else {
                registerButton.applyStyle(textColor: .white,
                                       backgroundColor: .gray,
                                       font: .book,
                                       textSize: .default)
                registerButton.isUserInteractionEnabled = false
                return
        }

        registerButton.applyStyle(textColor: .white,
                                  font: .medium,
                                  textSize: .default)
        registerButton.isUserInteractionEnabled = true
    }

    func setUpRXButtons() {
        registerButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [unowned self] in
                self.register()
                }, onCompleted: nil).disposed(by: viewModel.disposeBag)
    }

    func register() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let age = ageTextField.text else { return }

        viewModel.createUser(email: email, password: password, age: age).subscribe(onSuccess: { [weak self] in
            self?.registeredSuccessfully?()
        }, onError: { [weak self] error in
            self?.showAlert(message: (error as NSError).domain)
        }).disposed(by: viewModel.disposeBag)
    }

}
