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
    func response(for request: URLRequest, logger: NetworkLoggerType) -> Observable<Response> {
        return Observable.create { observer in
            guard let sessionTypeString = request.value(forHTTPHeaderField: HTTPHeaderName.sessionType.rawValue) else {
                return Disposables.create()
            }

            let sessionType = SessionType(rawValue: sessionTypeString)
            var task: URLSessionTask

            switch sessionType {
            case .upload:
                task = self.uploadTask(for: request, logger: logger, observer: observer)
            default:
                task = self.dataTask(for: request, logger: logger, observer: observer)
            }

            task.resume()

            return Disposables.create()
        }
    }
}

private extension Reactive where Base: URLSession {
    func dataTask(for request: URLRequest,
                  logger: NetworkLoggerType,
                  observer: AnyObserver<Response>) -> URLSessionTask {
        return base.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                observer.on(.error(NetworkErrorType.nonHttpResponse))
                return
            }

            logger.log(response: httpResponse, data: data, error: error)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode != ErrorCode.unauthorized.rawValue else {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .unauthorizedNotificationObserverKey, object: nil)
                    }
                    return
            }
            observer.on(.next(Response(httpResponse, data: data, error: error)))
            observer.on(.completed)
        }
    }

    func uploadTask(for request: URLRequest,
                    logger: NetworkLoggerType,
                    observer: AnyObserver<Response>) -> URLSessionTask {
        let data = request.httpBody ?? Data()
        let tempDir = FileManager.default.temporaryDirectory
        let localURL = tempDir.appendingPathComponent("throwaway")
        try? data.write(to: localURL)

        return base.uploadTask(with: request, fromFile: localURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                observer.on(.error(NetworkErrorType.nonHttpResponse))
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode != ErrorCode.unauthorized.rawValue else {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .unauthorizedNotificationObserverKey, object: nil)
                    }
                    return
            }
            logger.log(response: httpResponse, data: data, error: error)
            observer.on(.next(Response(httpResponse, data: data, error: error)))
            observer.on(.completed)
        }
    }
}
