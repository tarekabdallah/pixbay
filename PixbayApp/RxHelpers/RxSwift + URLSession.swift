//
//  RxSwift + URLSession.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: URLSession {
    func response(for request: URLRequest, logger: NetworkLoggerType) -> Single<Response> {
        return Single.create { single in
            self.base.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.error(NetworkErrorType.nonHttpResponse))
                    return
                }

                logger.log(response: httpResponse, data: data, error: error)
                single(.success(Response(httpResponse, data: data, error: error)))
            }.resume()
            return Disposables.create()
        }
    }
}
