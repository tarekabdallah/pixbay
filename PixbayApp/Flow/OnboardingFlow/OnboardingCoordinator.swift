//
//  OnboardingCoordinator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {
    typealias Dependencies = HasUserRepository

    let dependencies: Dependencies
    let moduleFactory: OnboardingCoordinatorModuleFactoryType
    var finishFlow: (() -> Void)?

    lazy var onboardingViewController: OnboardingViewController = {
        let onboardingViewController = moduleFactory.makeOnboardingViewController(dependencies: dependencies)
        onboardingViewController.onRegisterButtonTapped = { [unowned self] in
            self.showRegisterViewController()
        }
        onboardingViewController.loggedInSuccessfully = { [weak self] in
            self?.finishFlow?()
        }
        return onboardingViewController
    }()

    init(router: RouterType, dependencies: Dependencies, moduleFactory: OnboardingCoordinatorModuleFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }

    override func start() {
        showOnboardingViewController()
    }

    override func toPresent() -> UIViewController {
        showOnboardingViewController()
        return router.toPresent()
    }

}

extension OnboardingCoordinator {
    func showOnboardingViewController() {
        router.setRoot(onboardingViewController)
    }

    func showRegisterViewController() {
        let registerViewController = moduleFactory.makeRegisterViewController(dependencies: dependencies)
        registerViewController.registeredSuccessfully = { [weak self] in
            self?.finishFlow?()
        }
        router.push(registerViewController, animated: true, onPop: nil)
    }
}
