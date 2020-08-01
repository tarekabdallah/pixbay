//
//  HomeViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    typealias Dependencies = HasPixbayAppApi & HasUserSettings

    let searchPlaceholderText = "home_scene.placeholer.search_text".localized
    let noResultsFoundText = "home_scene.placeholer.no_results_found_text".localized

    let dependencies: Dependencies
    let disposeBag = DisposeBag()
    var currentPage = 1

    var reachedLastPage: Bool {
        currentPage == Constants.apiMaxPages
    }

    var fetchedImages = [ImageModel]() {
        didSet {
            displayedImages.accept(fetchedImages)
        }
    }

    var displayedImages = PublishRelay<[ImageModel]>()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetchImages(with searchText: String? = nil, resetPages: Bool = false) -> Single<Void> {
        if resetPages {
            currentPage = 1
        }

        return dependencies
            .pixbayAppApi
            .fetchImages(searchText: searchText,
                         page: currentPage).map { [weak self] images -> Void in
                            self?.currentPage += 1
                            if resetPages {
                                self?.fetchedImages = images
                            } else {
                                self?.fetchedImages.append(contentsOf: images)
                            }
                            return
            }
    }

    func clearUser() {
        dependencies.userSettings.clear()
    }
}
