//
//  HomeFlowCoordinatorTests.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import PixbayApp

class HomeFlowCoordinatorTests: XCTestCase {

    var coordinator: HomeCoordinator!
    var router: RouterMock!
    var moduleFactory: HomeCoordinatorModuleFactoryType!
    var dependencyProvider: DependencyProvider!

    // Child Coordinators
    var homeViewController: HomeViewController!
    var imageDetailsViewController: ImageDetailsViewController!

    override func setUp() {
        super.setUp()

        dependencyProvider = DependencyProvider()
        router = RouterMock()
        homeViewController = HomeViewController.loadFromStoryboard()
        imageDetailsViewController = ImageDetailsViewController.loadFromStoryboard()

        moduleFactory = HomeFlowModuleFactoryMock(homeViewController: homeViewController,
                                                  imageDetailsViewController: imageDetailsViewController)

        coordinator = HomeCoordinator(router: router,
                                      dependencies: dependencyProvider,
                                      moduleFactory: moduleFactory)
    }

    override func tearDown() {
        coordinator = nil
        router = nil
        moduleFactory = nil
        dependencyProvider = nil
        homeViewController = nil
        imageDetailsViewController = nil

        super.tearDown()
    }

    func testHomeCoordinator_runStart_navigationStackHasOneItem() {
        // When
        coordinator.start()

        // Then
        XCTAssertTrue(router.navigationStack.first is HomeViewController, "navigationStack first elements should be instance of HomeViewController")
        XCTAssertTrue(router.navigationStack.count == 1, "navigationStack count should be 1")
    }

    func testHomeCoordinator_viewDetails_navigationStackHasTwoItems() {
        // Given
        let imageDetails = ImageModel(id: 0, type: "", tags: "", previewURL: "", previewWidth: 0, previewHeight: 0, largeImageURL: "", imageWidth: 0, imageHeight: 0, views: 0, downloads: 0, favorites: 0, likes: 0, comments: 0, user: "")

        // When
        coordinator.start()
        homeViewController.onImageSelected?(imageDetails)

        // Then
        XCTAssertTrue(router.navigationStack.last is ImageDetailsViewController, "navigationStack last elements should be instance of ImageDetailsViewController")
        XCTAssertTrue(router.navigationStack.count == 2, "navigationStack count should be 2")
    }

    func testHomeCoordinator_logout_finishFlow() {
        // Given
        let exp = expectation(description: "Finish flow called")
        coordinator.finishFlow = {
            exp.fulfill()
        }

        // When
        coordinator.start()
        homeViewController.onLogout?()

        // Then
        wait(for: [exp], timeout: 5)
    }

    func testHomeCoordinator_toPresent_navigationStackHasOneItem() {
        XCTAssertTrue(coordinator.toPresent() is NavigationController, "toPresent should be instance of NavigationController")
    }
}
