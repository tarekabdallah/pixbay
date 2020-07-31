//
//  AppCoordinator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    let dependencyProvider: DependencyProvider
    let coordinatorFactory: AppCoordinatorFactoryType

    init(router: RouterType,
         dependencyProvider: DependencyProvider = DependencyProvider(),
         coordinatorFactory: AppCoordinatorFactoryType = AppCoordinatorFactory()) {
        self.dependencyProvider = dependencyProvider
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        runOnboardingFlow()
    }

    override func toPresent() -> UIViewController {
        return router.toPresent()
    }

}

extension AppCoordinator {
    func runOnboardingFlow() {
        var onboardingCoordinator = coordinatorFactory
            .makeOnboardingCoordinator(router: router,
                                       dependencies: dependencyProvider,
                                       moduleFactory: OnboardingCoordinatorModuleFactory())
        onboardingCoordinator.finishFlow = { [weak self, weak onboardingCoordinator] in
            self?.runMainFlow()
            self?.removeChild(coordinator: onboardingCoordinator)
        }
        addChild(coordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }

    func runMainFlow() {
        var homeCoordinator = coordinatorFactory
            .makeHomeCoordinator(router: router,
                                 dependencies: dependencyProvider,
                                 moduleFactory: HomeCoordinatorModuleFactory())
        homeCoordinator.finishFlow = { [weak self, weak homeCoordinator] in
            self?.runOnboardingFlow()
            self?.removeChild(coordinator: homeCoordinator)
        }
        addChild(coordinator: homeCoordinator)
        homeCoordinator.start()
    }
}
