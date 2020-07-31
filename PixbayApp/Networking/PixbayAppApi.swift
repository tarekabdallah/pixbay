//
//  PixbayAppApi.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

class PixbayAppApi {

    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }

    func fetchImages(searchText: String?, page: Int) -> Single<[ImageModel]> {
        let request = FetchImagesRequest(page: page, searchText: searchText)
        return NetworkOperation<[ImageModel]>(request: request).execute(in: dispatcher)
    }
}
