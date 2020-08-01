//
//  HomeViewModelTests.swift
//  PixbayAppTests
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import PixbayApp

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var dependencyProvider: DependencyProvider!

    override func setUp() {
        super.setUp()

        dependencyProvider = DependencyProvider()
        viewModel = HomeViewModel(dependencies: dependencyProvider)
    }

    override func tearDown() {
        viewModel = nil
        dependencyProvider = nil

        super.tearDown()
    }

    func testHomeViewModel_reachedLastPage_ShouldBeFalse() {
        XCTAssertFalse(viewModel.reachedLastPage)
    }

    func testHomeViewModel_reachedLastPage_ShouldBeTrue() {
        // Given
        viewModel.currentPage = 26

        // Then
        XCTAssertTrue(viewModel.reachedLastPage)
    }

    func testHomeViewModel_fetchedImages_ShouldBeEmpty() {
        XCTAssertTrue(viewModel.fetchedImages.isEmpty)
    }

    func testHomeViewModel_fetchedImages() {
        // Given
        let fetchedImages = [ImageModel(id: 0, type: "", tags: "", previewURL: "", previewWidth: 0, previewHeight: 0, largeImageURL: "", imageWidth: 0, imageHeight: 0, views: 0, downloads: 0, favorites: 0, likes: 0, comments: 0, user: "")]
        viewModel.fetchedImages = fetchedImages

        // Then
        XCTAssertEqual(viewModel.fetchedImages.count, fetchedImages.count )
    }

    func testHomeViewModel_displayImage() {
        // Given
        let fetchedImages = [ImageModel(id: 0, type: "", tags: "", previewURL: "", previewWidth: 0, previewHeight: 0, largeImageURL: "", imageWidth: 0, imageHeight: 0, views: 0, downloads: 0, favorites: 0, likes: 0, comments: 0, user: "")]
        let exp = expectation(description: "Finish flow called")
        _ = viewModel.displayedImages.subscribe { _ in
            exp.fulfill()
        }

        // When
        viewModel.fetchedImages = fetchedImages

        // Then
        wait(for: [exp], timeout: 5)
    }

    func testHomeViewModel_clearUser() {
        // Given
        dependencyProvider.userSettings.setUser(User(email: nil, password: nil, age: nil))

        // When
        viewModel.clearUser()

        // Then
        XCTAssertNil(dependencyProvider.userSettings.user)
    }
}
