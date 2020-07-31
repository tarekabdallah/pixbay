//
//  ImageCellViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

struct ImageCellViewModel {
    let image: ImageModel

    var imageWidth: CGFloat {
        CGFloat(image.previewWidth)
    }

    var imageHeight: CGFloat {
        CGFloat(image.previewHeight)
    }
}
