//
//  MultipartData.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct MultipartData {
    let rawData: Data?
    let fieldName: String
    let fileName: String
    let mimeType: String
    private(set) var boundary: String

    var data: Data? {
        return buildMultipartsData()
    }

    init(rawData: Data?,
         fieldName: String,
         fileName: String,
         mimeType: String) {
        self.rawData = rawData
        self.fieldName = fieldName
        self.fileName = fileName
        self.mimeType = mimeType
        boundary = "Boundary-\(UUID().uuidString)"
    }
}

// MARK: - Private Helper Methods
private extension MultipartData {
    func buildMultipartsData() -> Data? {
        guard let rawData = rawData else {
            return nil
        }

        let data = NSMutableData()
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.append("Content-Type: \(mimeType)\r\n\r\n")
        data.append(rawData)
        data.append("\r\n")
        data.append("--\(boundary)--\r\n")
        return data as Data
    }
}
