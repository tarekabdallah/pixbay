//
//  OnboardingFlowModuleFactoryMock.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
@testable import PixbayApp

class OnboardingFlowModuleFactoryMock: OnboardingCoordinatorModuleFactoryType {
    let onbaordingViewController: OnboardingViewController
    let registerViewController: RegisterViewController

    init(onbaordingViewController: OnboardingViewController, registerViewController: RegisterViewController) {
        self.onbaordingViewController = onbaordingViewController
        self.registerViewController = registerViewController
    }

    func makeOnboardingViewController(dependencies: OnboardingViewModel.Dependencies) -> OnboardingViewController {
        return onbaordingViewController
    }

    func makeRegisterViewController(dependencies: RegisterViewModel.Dependencies) -> RegisterViewController {
        return registerViewController
    }
}
