//
//  TagCollectionViewCell.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    func configure(with viewModel: TagCellViewModel) {
        tagLabel.text = viewModel.tag
    }
}

// MARK: Private Helper Methods
private extension TagCollectionViewCell {
    func configureViews() {
        tagLabel.applyStyle(textColor: .darkText,
                            font: .book,
                            size: .details)
        backgroundColor = .lightGreen
        cornerRadius = 5
    }
}
