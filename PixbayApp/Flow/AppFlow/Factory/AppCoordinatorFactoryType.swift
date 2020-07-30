//
//  AppCoordinatorFactoryType.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol AppCoordinatorFactoryType {
    func makeOnboardingCoordinator(router: RouterType,
                                   dependencies: OnboardingCoordinator.Dependencies,
                                   moduleFactory: OnboardingCoordinatorModuleFactoryType)
    -> Coordinator & OnboardingCoordinatorOutput
}
