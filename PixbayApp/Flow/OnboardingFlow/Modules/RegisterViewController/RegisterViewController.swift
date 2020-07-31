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

class RegisterViewController: UIViewController {

    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var ageTextField: TextField!
    @IBOutlet private weak var registerButton: ActionButton!
    var viewModel: RegisterViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
