//
//  ResponseHandler.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol ResponseHandler {
    // Empty on purpose
}

extension ResponseHandler where Self: Operation {
    func handle(response: Response) throws -> Output? {
        if case let Response.success(data) = response {
            let decoder = JSONDecoder()
            guard let decodedResponse = try? decoder.decode(RootApiResponse<Output>.self, from: data) else {
                throw NetworkErrorType.parsingError
            }
            return decodedResponse.hits ?? EmptyDataModel() as? Output
        } else if Output.self == EmptyDataModel.self {
            return EmptyDataModel() as? Output
        }
        return nil
    }
}
