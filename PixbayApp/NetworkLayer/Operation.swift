//
//  Operation.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

protocol Operation: ResponseHandler {
    associatedtype Output: Decodable

    var request: Request { get }
    var disposeBag: DisposeBag { get set }

    func execute(in dispatcher: Dispatcher) -> Single<Output>
}

extension Operation {
    func execute(in dispatcher: Dispatcher) -> Single<Output> {
        return Single<Output>.create { single in
            do {
                try dispatcher.execute(request: self.request).subscribe(onSuccess: { response in
                    do {
                        guard let outputObject = try self.handle(response: response) else {
                            return
                        }
                        DispatchQueue.main.async {
                            single(.success(outputObject))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            single(.error(error))
                        }
                    }
                }, onError: { error in
                    DispatchQueue.main.async {
                        single(.error(error))
                    }
                }).disposed(by: self.disposeBag)
            } catch {
                DispatchQueue.main.async {
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
