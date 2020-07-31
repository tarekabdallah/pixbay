//
//  HomeCoordinator.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator, HomeCoordinatorOutput {
    typealias Dependencies = HasPixbayAppApi

    let dependencies: Dependencies
    let moduleFactory: HomeCoordinatorModuleFactoryType
    var finishFlow: (() -> Void)?

    lazy var homeViewController: HomeViewController = {
        let homeViewController = moduleFactory.makeHomeViewController(dependencies: dependencies)
        homeViewController.onImageSelected = { [unowned self] imageDetails in
            self.showImageDetailsViewController(imageDetails: imageDetails)
        }
        return homeViewController
    }()

    init(router: RouterType, dependencies: Dependencies, moduleFactory: HomeCoordinatorModuleFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }

    override func start() {
        showHomeViewController()
    }

    override func toPresent() -> UIViewController {
        showHomeViewController()
        return router.toPresent()
    }

}

extension HomeCoordinator {
    func showHomeViewController() {
        router.setRoot(homeViewController)
    }

    func showImageDetailsViewController(imageDetails: ImageModel) {
        let imageDetailsViewController = moduleFactory.makeImageDetailsViewController(imageDetails: imageDetails)
        router.push(imageDetailsViewController, animated: true, onPop: nil)
    }
}
