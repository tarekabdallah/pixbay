//
//  OnboardingCoordinatorTests.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import PixbayApp

class OnboardingCoordinatorTests: XCTestCase {

    var coordinator: OnboardingCoordinator!
    var router: RouterMock!
    var moduleFactory: OnboardingCoordinatorModuleFactoryType!
    var dependencyProvider: DependencyProvider!

    // Child Coordinators
    var onboardingViewController: OnboardingViewController!
    var registerViewController: RegisterViewController!

    override func setUp() {
        super.setUp()

        dependencyProvider = DependencyProvider()
        router = RouterMock()
        onboardingViewController =  OnboardingViewController.loadFromStoryboard()
        registerViewController =  RegisterViewController.loadFromStoryboard()

        moduleFactory = OnboardingFlowModuleFactoryMock(onbaordingViewController: onboardingViewController,
                                                        registerViewController: registerViewController)

        coordinator = OnboardingCoordinator(router: router,
                                            dependencies: dependencyProvider,
                                            moduleFactory: moduleFactory)
    }

    override func tearDown() {
        coordinator = nil
        router = nil
        moduleFactory = nil
        dependencyProvider = nil
        onboardingViewController = nil
        registerViewController = nil

        super.tearDown()
    }

    func testOnboardingCoordinator_runStart_navigationStackHasOneItem() {
        // When
        coordinator.start()

        // Then
        XCTAssertTrue(router.navigationStack.first is OnboardingViewController, "navigationStack first elements should be instance of OnboardingViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }

    func testOnboardingCoordinator_runStart_navigationStackHasTwoItems() {
        // When
        coordinator.start()
        onboardingViewController.onRegisterButtonTapped?()

        // Then
        XCTAssertTrue(router.navigationStack.last is RegisterViewController, "navigationStack last elements should be instance of RegisterViewController")
        XCTAssertTrue(router.navigationStack.count == 2, "navigationStack count should be 2")
    }

    func testOnboardingCoordinator_toPresent_navigationStackHasOneItem() {
        XCTAssertTrue(coordinator.toPresent() is NavigationController, "toPresent should be instance of NavigationController")
    }

    func testOnboardingCoordinator_login_finishFlow() {
        // Given
        let exp = expectation(description: "Finish flow called")
        coordinator.finishFlow = {
            exp.fulfill()
        }

        // When
        coordinator.start()
        onboardingViewController.loggedInSuccessfully?()

        // Then
        wait(for: [exp], timeout: 5)
    }

    func testOnboardingCoordinator_register_finishFlow() {
        // Given
        let exp = expectation(description: "Finish flow called")
        coordinator.finishFlow = {
            exp.fulfill()
        }

        // When
        coordinator.start()
        onboardingViewController.onRegisterButtonTapped?()
        registerViewController.registeredSuccessfully?()
    
        // Then
        wait(for: [exp], timeout: 5)
    }
}
