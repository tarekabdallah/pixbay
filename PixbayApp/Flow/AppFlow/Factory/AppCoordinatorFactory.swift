//
//  AppCoordinatorFactory.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct AppCoordinatorFactory: AppCoordinatorFactoryType {
    func makeOnboardingCoordinator(router: RouterType,
                                   dependencies: OnboardingCoordinator.Dependencies,
                                   moduleFactory: OnboardingCoordinatorModuleFactoryType)
        -> Coordinator & OnboardingCoordinatorOutput {
            let onboardingCoordinator = OnboardingCoordinator(router: router,
                                                              dependencies: dependencies,
                                                              moduleFactory: moduleFactory)
            return onboardingCoordinator
    }

    func makeHomeCoordinator(router: RouterType,
                             dependencies: HomeCoordinator.Dependencies,
                             moduleFactory: HomeCoordinatorModuleFactoryType)
        -> Coordinator & HomeCoordinatorOutput {
            let homeCoordinator = HomeCoordinator(router: router,
                                                  dependencies: dependencies,
                                                  moduleFactory: moduleFactory)
            return homeCoordinator
    }
}
