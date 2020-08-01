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
    @IBOutlet private weak var tagsCollectionView: UICollectionView!

    var viewModel: ImageCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    func configure(with viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        pixbayImageView.setImage(from: viewModel.image.previewURL, placeHolder: UIImage(named: "logo"))
        userNameLabel.text = viewModel.image.user.capitalizingFirstLetter
        tagsCollectionView.reloadData()
    }
}

// MARK: - Private Helper Methods
private extension ImageTableViewCell {
    func configureViews() {
        userNameLabel.applyStyle(textColor: .darkText, font: .medium, size: .title)
        tagsCollectionView.register(cell: TagCollectionViewCell.self)
        if let flowLayout = tagsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumInteritemSpacing = 8
        }
        tagsCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension ImageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.tags.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cell: TagCollectionViewCell.self, indexPath: indexPath)
        if let viewModel = viewModel {
            cell.configure(with: TagCellViewModel(tag: viewModel.tags[indexPath.row]))
        }
        return cell
    }
}
