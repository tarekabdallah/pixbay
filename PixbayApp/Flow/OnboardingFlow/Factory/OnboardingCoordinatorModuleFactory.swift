//
//  OnboardingCoordinatorModuleFactory.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct OnboardingCoordinatorModuleFactory: OnboardingCoordinatorModuleFactoryType {
    func makeOnboardingViewController(dependencies: OnboardingViewModel.Dependencies)
        -> OnboardingViewController {
            let onboardingViewController = OnboardingViewController.loadFromStoryboard()
            onboardingViewController.viewModel = OnboardingViewModel(dependencies: dependencies)
            return onboardingViewController
    }
}
