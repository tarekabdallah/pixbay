//
//  RouterMock.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
@testable import PixbayApp

class RouterMock: RouterType {
    private(set) var navigationStack: [UIViewController] = []
    private(set) var presented: UIViewController?
    private var completions: [UIViewController : () -> Void] = [:]

    lazy var navigationController: UINavigationController = {
        return NavigationController()
    }()

    var rootViewController: UIViewController? {
        return nil
    }

    func present(_ module: Presentable, animated: Bool, presentationStyle: UIModalPresentationStyle) {
        presented = module.toPresent()
    }

    func dismiss(animated: Bool, onDismiss: (() -> Void)?) {
        presented = nil
    }

    func push(_ module: Presentable, animated: Bool, onPop: (() -> Void)?) {
        let controller = module.toPresent()

        // Avoid pushing UINavigationController onto stack
        guard controller is UINavigationController == false else {
            return
        }

        if let onPop = onPop {
            completions[controller] = onPop
        }

        navigationStack.append(controller)
    }

    func pop(animated: Bool) {
        let controller = navigationStack.removeLast()
        runCompletion(for: controller)
    }

    func setRoot(_ module: Presentable?) {
        navigationStack = module?.toPresent() == nil ? [] : [module!.toPresent()]
    }

    func dismissToRoot(animated: Bool) {
        navigationController.dismiss(animated: animated) {
            self.popToRoot(animated: animated)
        }
    }

    func popToRoot(animated: Bool) {
        guard let first = navigationStack.first else { return }

        navigationStack.forEach { controller in
            runCompletion(for: controller)
        }

        navigationStack = [first]
    }

    func pop(to module: Presentable, animated: Bool) {
        navigationController.popToViewController(module.toPresent(), animated: true)
    }

    func toPresent() -> UIViewController {
        return navigationController
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }
}
