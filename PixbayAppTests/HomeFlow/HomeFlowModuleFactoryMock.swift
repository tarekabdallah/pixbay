//
//  HomeFlowModuleFactoryMock.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

@testable import PixbayApp

class HomeFlowModuleFactoryMock: HomeCoordinatorModuleFactoryType {
    let homeViewController: HomeViewController
    let imageDetailsViewController: ImageDetailsViewController

    init(homeViewController: HomeViewController, imageDetailsViewController: ImageDetailsViewController) {
        self.homeViewController = homeViewController
        self.imageDetailsViewController = imageDetailsViewController
    }

    func makeHomeViewController(dependencies: HomeViewModel.Dependencies) -> HomeViewController {
        return homeViewController
    }

    func makeImageDetailsViewController(imageDetails: ImageModel) -> ImageDetailsViewController {
        imageDetailsViewController
    }
}
