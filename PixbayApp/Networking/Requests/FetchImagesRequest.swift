//
//  FetchImagesRequest.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

struct FetchImagesRequest: Request {
    let page: Int
    let searchText: String?

    var path: String {
        return ""
    }

    var parameters: RequestParameters {
        return .query([
            "page": page,
            "q": searchText
        ])
    }
}
