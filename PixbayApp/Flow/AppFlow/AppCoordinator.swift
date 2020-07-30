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
        // TODO
    }

    override func toPresent() -> UIViewController {
        return router.toPresent()
    }

}

extension AppCoordinator {
    func runOnboardingFlow() {
    }

    func runMainFlow() {

    }
}
