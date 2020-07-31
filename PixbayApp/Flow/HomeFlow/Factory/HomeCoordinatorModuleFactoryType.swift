//
//  HomeCoordinatorModuleFactoryType.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol HomeCoordinatorModuleFactoryType {
    func makeHomeViewController(dependencies: HomeViewModel.Dependencies) -> HomeViewController
}
