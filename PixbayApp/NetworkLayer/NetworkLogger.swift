//
//  NetworkLogger.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class NetworkLogger: NetworkLoggerType {
    func log(request: URLRequest) {
        if AppEnvironment.shouldUseDebugConfig {
            logRequest(request)
        }
    }

    func log(response: URLResponse, data: Data?, error: Error?) {
        if AppEnvironment.shouldUseDebugConfig {
            logResponse(response, data: data, error: error)
        }
    }
}

// MARK: - Private Helper Methods
extension NetworkLogger {
    func logRequest(_ request: URLRequest) {
        let httpMethod = request.httpMethod ?? "HTTPMethod not specified"
        let path = request.url?.absoluteString ?? "Path not specified"
        let headers = request.allHTTPHeaderFields ?? [:]
        let bodyData = request.httpBody

        print("============================== \(httpMethod) REQUEST ==============================")
        print(path)
        print("============================== HEADERS ==============================")
        for (key, value) in headers {
            print("== \(key): \(value)")
        }
        print("============================== HEADERS END ==============================")

        logData(data: bodyData)
        print("============================== END \(httpMethod) ==============================\n\n\n")
    }

    func logResponse(_ response: URLResponse, data: Data?, error: Error?) {
        guard let response = response as? HTTPURLResponse else { return }
        let path = response.url?.absoluteString ?? "Path not specified"
        let headers = response.allHeaderFields

        print("============================= \(response.statusCode) RESPONSE ==============================")
        print(path)
        print("============================== HEADERS ==============================")
        for (key, value) in headers {
            print("== \(key): \(value)")
        }
        print("============================= HEADERS END ==============================")

        logData(data: data)
        logError(error: error)
        print("============================== END RESPONSE \(response.statusCode) ==============================\n\n\n")
    }

    func logData(data: Data?) {
        do {
            guard let data = data,
                let jsonBody = try JSONSerialization
                    .jsonObject(with: data, options: []) as? [String: Any] else { return }
            print("============================== BODY ==============================")
            for (key, value) in jsonBody {
                print("== \(key): \(value)")
            }
            print("============================== BODY END ==============================")
        } catch {
            print("== JSON ERROR \(error.localizedDescription)")
        }
    }

    func logError(error: Error?) {

    }
}
