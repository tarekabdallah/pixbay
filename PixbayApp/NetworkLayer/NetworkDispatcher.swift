//
//  NetworkDispatcher.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RxSwift

class NetworkDispatcher: Dispatcher {
    private let environment: Environment
    private let logger: NetworkLoggerType

    required init(environment: Environment, logger: NetworkLoggerType) {
        self.environment = environment
        self.logger = logger
    }

    func execute(request: Request) throws -> Single<Response> {
        let urlRequest = try prepareUrlRequest(for: request)
        logger.log(request: urlRequest)
            return URLSession
                .shared
                .rx
                .response(for: urlRequest, logger: logger)
                .retry(2)
    }

    private func prepareUrlRequest(for request: Request) throws -> URLRequest {
        let urlString = environment.host + request.path

        guard let url = URL(string: urlString) else {
            throw NetworkErrorType.invalidUrl
        }

        var urlRequest = URLRequest(url: url)

        environment.headers.forEach { header in
            guard let value = header.value else { return }
            urlRequest.addValue(value, forHTTPHeaderField: header.key.rawValue)
        }
        request.headers?.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key.rawValue)
        }

        urlRequest.httpMethod = request.method.rawValue

        switch request.parameters {
        case let .body(parameters):
            if let parameters = parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.addValue("application/json", forHTTPHeaderField: HTTPHeaderName.contentType.rawValue)
            }
        case let .query(parameters):
            guard let parameters = parameters, var urlComponents = URLComponents(string: urlString) else {
                return urlRequest
            }

            let queryItem = parameters.map { param in
                URLQueryItem(name: param.key, value: String(describing: param.value))
            }
            urlComponents.queryItems = queryItem
            urlRequest.url = urlComponents.url
        case let .array(parameters):
            if let parameters = parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.addValue("application/json", forHTTPHeaderField: HTTPHeaderName.contentType.rawValue)
            }
        }

        return urlRequest
    }
}
