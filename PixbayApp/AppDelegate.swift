//
//  AppDelegate.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var appCoordinator: Coordinator = {
        let router = Router()
        return AppCoordinator(router: router)
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.toPresent()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        UIViewController.swizzleViewDidLoad()

        appCoordinator.start(with: nil)

        initialiseServices(application: application, launchOptions: launchOptions)
        return true
    }
}

// MARK: - Private helper methods
private extension AppDelegate {
    func initialiseServices(application: UIApplication,
                            launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        NetfoxService.initialise()
        FirebaseService.initialise()
    }
}
