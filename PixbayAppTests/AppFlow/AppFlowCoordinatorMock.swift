//
//  AppFlowCoordinatorMock.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
@testable import PixbayApp

class AppFlowCoordinatorFactoryMock: AppCoordinatorFactoryType {
    let onbaordingCoordinator: OnboardingCoordinator
    let homeCoordinator: HomeCoordinator

    init(onbaordingCoordinator: OnboardingCoordinator, homeCoordinator: HomeCoordinator) {
        self.onbaordingCoordinator = onbaordingCoordinator
        self.homeCoordinator = homeCoordinator
    }

    func makeOnboardingCoordinator(router: RouterType, dependencies: OnboardingCoordinator.Dependencies, moduleFactory: OnboardingCoordinatorModuleFactoryType) -> Coordinator & OnboardingCoordinatorOutput {
        return onbaordingCoordinator
    }

    func makeHomeCoordinator(router: RouterType, dependencies: HomeCoordinator.Dependencies, moduleFactory: HomeCoordinatorModuleFactoryType) -> Coordinator & HomeCoordinatorOutput {
        return homeCoordinator
    }
}
