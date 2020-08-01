//
//  ImageModel.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct ImageModel: Decodable {
    let id: Int
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let views: Int
    let downloads: Int
    let favorites: Int
    let likes: Int
    let comments: Int
    let user: String
}
