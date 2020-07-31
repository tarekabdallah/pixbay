//
//  HomeCoordinatorOutput.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol HomeCoordinatorOutput {
    var finishFlow: (() -> Void)? { get set }
}
