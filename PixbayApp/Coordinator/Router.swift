//
//  Router.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class Router: NSObject, RouterType {
    private var completions: [UIViewController : () -> Void]

    var navigationController: UINavigationController

    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
        self.completions = [:]
        super.init()
    }

    func present(_ module: Presentable, animated: Bool, presentationStyle: UIModalPresentationStyle) {
        let presentedModule = module.toPresent()
        presentedModule.modalPresentationStyle = presentationStyle
        navigationController.present(presentedModule, animated: animated, completion: nil)
    }

    func push(_ module: Presentable, animated: Bool, onPop: (() -> Void)? = nil) {
        let pushModule = module.toPresent()
        guard !(pushModule is UINavigationController) else { return }
        if let completion = onPop {
            completions[pushModule] = completion
        }
        navigationController.pushViewController(pushModule, animated: animated)
    }

    func pop(animated: Bool) {
        guard let controller = navigationController.popViewController(animated: animated) else { return }
        completions[controller]?()
    }

    func dismiss(animated: Bool, onDismiss: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: onDismiss)
    }

    /// Runs all completions and removes all VC except the root
    func setRoot(_ module: Presentable?) {
        // Call all completions and make the current VC is the root
        completions.forEach { $0.value() }
        let rootVC = module?.toPresent()
        navigationController.setViewControllers(rootVC == nil ? [] : [rootVC!], animated: false)
    }

    func popToRoot(animated: Bool) {
        guard let popedViewControllers = navigationController.popToRootViewController(animated: true) else { return }
        for viewController in popedViewControllers {
            completions[viewController]?()
        }
    }

    func pop(to module: Presentable, animated: Bool) {
        guard let poppedViewControllers = navigationController.popToViewController(module.toPresent(),
                                                                                   animated: animated) else { return }
         for viewController in poppedViewControllers {
             completions[viewController]?()
         }
    }

    func dismissToRoot(animated: Bool) {
        dismiss(animated: animated) {
            self.popToRoot(animated: animated)
        }
    }

    func toPresent() -> UIViewController {
        return navigationController
    }
}
