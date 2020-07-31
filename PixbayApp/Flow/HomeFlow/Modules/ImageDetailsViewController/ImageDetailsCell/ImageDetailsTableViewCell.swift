//
//  ImageDetailsTableViewCell.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ImageDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var fullSizeImageView: UIImageView!
    @IBOutlet private weak var imageSizeLabel: UILabel!
    @IBOutlet private weak var imageTypeLabel: UILabel!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var tagsCollectionView: UICollectionView!

    var viewModel: ImageDetailsCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureViews()
    }

    func configure(with viewModel: ImageDetailsCellViewModel) {
        self.viewModel = viewModel
        fullSizeImageView.setImage(from: viewModel.imageDetails.largeImageURL,
                                   placeHolder: UIImage(named: "logo"))
        imageSizeLabel.text = viewModel.imageSizeText
        imageTypeLabel.text = viewModel.imageTypeText.capitalizingFirstLetter
        tagsCollectionView.reloadData()
        updateCollectionViewHeight()
    }
}

// MARK: - Private Helper Methods
private extension ImageDetailsTableViewCell {
    func configureViews() {
        imageSizeLabel.applyStyle(textColor: .darkText, font: .medium, size: .default)
        imageTypeLabel.applyStyle(textColor: .darkText, font: .medium, size: .title)
        tagsCollectionView.register(cell: TagCollectionViewCell.self)
        if let flowLayout = tagsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        tagsCollectionView.dataSource = self
    }

    func updateCollectionViewHeight() {
        let height = tagsCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource
extension ImageDetailsTableViewCell: UICollectionViewDataSource {
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
