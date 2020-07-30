//
//  BaseCoordinator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let router: RouterType

    init(router: RouterType) {
        self.router = router
    }

    func start() {
        fatalError("Must override in Subclass")
    }

    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func toPresent() -> UIViewController {
        return router.toPresent()
    }

    func removeChild(coordinator: Coordinator?) {
        guard let coordinator = coordinator, !childCoordinators.isEmpty else {
            return
        }

        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.forEach { coordinator.removeChild(coordinator: $0) }
        }

        childCoordinators.removeAll { $0 === coordinator }
    }
}
