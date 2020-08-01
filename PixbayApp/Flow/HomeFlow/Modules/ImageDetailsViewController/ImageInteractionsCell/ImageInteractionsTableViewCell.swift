//
//  ImageInteractionsTableViewCell.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ImageInteractionsTableViewCell: UITableViewCell {

    @IBOutlet private weak var uploaderName: UILabel!
    @IBOutlet private weak var numberOfDownloads: IconLabel!
    @IBOutlet private weak var numberOfViews: IconLabel!
    @IBOutlet private weak var numberOfLikes: IconLabel!
    @IBOutlet private weak var numberOfComments: IconLabel!
    @IBOutlet private weak var numberOfFavorites: IconLabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    func configure(with viewModel: ImageInteractionsCellViewModel) {
        uploaderName.text = viewModel.imageDetails.user.capitalizingFirstLetter
        numberOfDownloads.text = viewModel.imageDetails.comments.toString
        numberOfViews.text = viewModel.imageDetails.views.toString
        numberOfLikes.text = viewModel.imageDetails.likes.toString
        numberOfComments.text = viewModel.imageDetails.comments.toString
        numberOfFavorites.text = viewModel.imageDetails.favorites.toString
    }
}

// MARK: - Private Helper Methods
private extension ImageInteractionsTableViewCell {
    func configureViews() {
        uploaderName.applyStyle(textColor: .darkText, font: .medium, size: .title)
        numberOfDownloads.applyStyle(textColor: .darkText, font: .medium, size: .default)
        numberOfViews.applyStyle(textColor: .darkText, font: .medium, size: .default)
        numberOfLikes.applyStyle(textColor: .darkText, font: .medium, size: .default)
        numberOfComments.applyStyle(textColor: .darkText, font: .medium, size: .default)
        numberOfFavorites.applyStyle(textColor: .darkText, font: .medium, size: .default)

        numberOfDownloads.icon = UIImage(named: InteractionImage.download.rawValue)
        numberOfViews.icon = UIImage(named: InteractionImage.views.rawValue)
        numberOfLikes.icon = UIImage(named: InteractionImage.like.rawValue)
        numberOfComments.icon = UIImage(named: InteractionImage.comment.rawValue)
        numberOfFavorites.icon = UIImage(named: InteractionImage.favorite.rawValue)
    }
}
