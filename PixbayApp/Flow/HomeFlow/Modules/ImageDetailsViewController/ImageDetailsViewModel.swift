//
//  ImageDetailsViewModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ImageDetailsViewModel {
    enum CellType {
        case imageDetails
        case imageInteractions
    }

    let titleText = "image_details_scene.label.title_text".localized
    let disposeBag = DisposeBag()
    let imageDetails: ImageModel
    var sections = BehaviorSubject<[CellType]>(value: [.imageDetails, .imageInteractions])
}
