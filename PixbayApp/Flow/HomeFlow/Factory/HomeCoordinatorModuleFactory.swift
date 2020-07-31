//
//  HomeCoordinatorModuleFactory.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct HomeCoordinatorModuleFactory: HomeCoordinatorModuleFactoryType {
    func makeHomeViewController(dependencies: HomeViewModel.Dependencies) -> HomeViewController {
        let homeViewController = HomeViewController.loadFromStoryboard()
        homeViewController.viewModel = HomeViewModel(dependencies: dependencies)
        return homeViewController
    }

    func makeImageDetailsViewController(imageDetails: ImageModel) -> ImageDetailsViewController {
        let imageDetailsViewController = ImageDetailsViewController.loadFromStoryboard()
        imageDetailsViewController.viewModel = ImageDetailsViewModel(imageDetails: imageDetails)
        return imageDetailsViewController
    }
}
