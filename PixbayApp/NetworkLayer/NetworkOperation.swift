//
//  NetworkOperation.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

class NetworkOperation<ReturnResponse: Decodable>: Operation {
    typealias Output = ReturnResponse

    var request: Request
    var disposeBag: DisposeBag = DisposeBag()

    init(request: Request) {
        self.request = request
    }
}
