//
//  ImageDetailsCellViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift

class ImageDetailsCellViewModel {
    let imageDetails: ImageModel
    let disposeBag = DisposeBag()

    init(imageDetails: ImageModel) {
        self.imageDetails = imageDetails
    }

    var imageSizeText: String {
        "image_details_cell.label.size_text".localized(with: imageDetails.imageWidth, imageDetails.imageHeight)
    }

    var imageTypeText: String {
        "image_details_cell.label.type_text".localized(with: imageDetails.type)
    }

    var tags: [String] {
        imageDetails
            .tags
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    }
}
