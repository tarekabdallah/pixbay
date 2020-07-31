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
    typealias Dependencies = HasPixbayAppApi

    let titleText = "".localized
    let dependencies: Dependencies
    let disposeBag = DisposeBag()
    private var currentPage = 1
    var fetchedImages = [ImageModel]() {
        didSet {
            filteredImages.accept(fetchedImages)
        }
    }

    var filteredImages = PublishRelay<[ImageModel]>()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetchImages(with searchText: String? = nil, restPages: Bool = false) -> Single<Void> {
        if restPages {
            currentPage = 1
        }

        return dependencies.pixbayAppApi.fetchImages(searchText: searchText,
                                                     page: currentPage).map { [weak self] images -> Void in
            self?.currentPage += 1
            self?.fetchedImages.append(contentsOf: images)
            return
        }
    }
}
