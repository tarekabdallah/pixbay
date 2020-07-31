//
//  ImageTableViewCell.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var pixbayImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    func configure(with viewModel: ImageCellViewModel) {
        pixbayImageView.setImage(from: viewModel.image.previewURL, placeHolder: UIImage(systemName: "logo"))
        NSLayoutConstraint.activate([
            pixbayImageView.heightAnchor.constraint(equalToConstant: viewModel.imageHeight),
            pixbayImageView.widthAnchor.constraint(equalToConstant: viewModel.imageWidth)
        ])
        userNameLabel.text = viewModel.image.user
    }
}

// MARK: - Private Helper Methods
private extension ImageTableViewCell {
    func configureViews() {
        userNameLabel.applyStyle(textColor: .primary, font: .medium, size: .title)
    }
}
