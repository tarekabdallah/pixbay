//
//  AppCoordinatorTests.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import PixbayApp

class AppCoordinatorTests: XCTestCase {

    var coordinator: AppCoordinator!
    var router: RouterMock!
    var appCoordinatorFactory: AppCoordinatorFactoryType!
    var dependencyProvider: DependencyProvider!

    // Child Coordinators
    var onboardingCoordinator: OnboardingCoordinator!
    var homeCoordinator: HomeCoordinator!

    override func setUp() {
        super.setUp()

        dependencyProvider = DependencyProvider()
        router = RouterMock()
        onboardingCoordinator = OnboardingCoordinator(router: router,
                                                      dependencies: dependencyProvider,
                                                      moduleFactory: OnboardingCoordinatorModuleFactory())
        homeCoordinator = HomeCoordinator(router: router,
                                          dependencies: dependencyProvider,
                                          moduleFactory: HomeCoordinatorModuleFactory())
        appCoordinatorFactory = AppFlowCoordinatorFactoryMock(onbaordingCoordinator: onboardingCoordinator,
                                                              homeCoordinator: homeCoordinator)
        coordinator = AppCoordinator(router: router,
                                     dependencyProvider: dependencyProvider,
                                     coordinatorFactory: appCoordinatorFactory)
    }

    override func tearDown() {
        coordinator = nil
        router = nil
        appCoordinatorFactory = nil
        dependencyProvider = nil
        onboardingCoordinator = nil
        homeCoordinator = nil

        super.tearDown()
    }

    func testAppCoordinator_runStart_userNotLoggedIn_navigationStackHasOneItem() {
        // Given
        dependencyProvider.userSettings.clear()

        // When
        coordinator.start()

        // Then
        XCTAssertTrue(router.navigationStack.first is OnboardingViewController, "navigationStack first elements should be instance of OnboardingViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }

    func testAppCoordinator_runStart_userLoggedIn_navigationStackHasOneItem() {
        // Given
        dependencyProvider.userSettings.setUser(User(email: nil, password: nil, age: nil))

        // When
        coordinator.start()

        // Then
        XCTAssertTrue(router.navigationStack.first is HomeViewController, "navigationStack first elements should be instance of HomeViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }

    func testAppCoordinator_runStart_userNotLoggedIn_finishFlow_navigationStackHasOneItem() {
        // Given
        dependencyProvider.userSettings.clear()

        // When
        coordinator.start()
        onboardingCoordinator.finishFlow?()
        // Then
        XCTAssertTrue(router.navigationStack.first is HomeViewController, "navigationStack first elements should be instance of HomeViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }

    func testAppCoordinator_runStart_userLoggedIn_finishFlow_navigationStackHasOneItem() {
        // Given
        dependencyProvider.userSettings.setUser(User(email: nil, password: nil, age: nil))

        // When
        coordinator.start()
        homeCoordinator.finishFlow?()

        // Then
        XCTAssertTrue(router.navigationStack.first is OnboardingViewController, "navigationStack first elements should be instance of OnboardingViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }
}
