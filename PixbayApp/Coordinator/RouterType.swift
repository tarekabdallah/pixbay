//
//  Router.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RouterType: Presentable {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ module: Presentable, animated: Bool, presentationStyle: UIModalPresentationStyle)
    func push(_ module: Presentable, animated: Bool, onPop: (() -> Void)?)
    func pop(animated: Bool)
    func dismiss(animated: Bool, onDismiss: (() -> Void)?)
    func setRoot(_ module: Presentable?)
    func popToRoot(animated: Bool)
    func pop(to module: Presentable, animated: Bool)
    func dismissToRoot(animated: Bool)
}
