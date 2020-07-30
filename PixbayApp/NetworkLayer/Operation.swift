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

    func execute(in dispatcher: Dispatcher) -> Observable<Output>
}

extension Operation where Self: Request {
    func execute(in dispatcher: Dispatcher) -> Observable<Output> {
        return Observable<Output>.create { observer in
            do {
                try dispatcher.execute(request: self).subscribe(onNext: { response in
                    do {
                        guard let outputObject = try self.handle(response: response) else {
                            return
                        }
                        DispatchQueue.main.async {
                            observer.onNext(outputObject)
                            observer.on(.completed)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            observer.onError(error)
                        }
                    }
                }, onError: { error in
                    DispatchQueue.main.async {
                        observer.onError(error)
                    }
                }).disposed(by: self.disposeBag)
            } catch {
                DispatchQueue.main.async {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
