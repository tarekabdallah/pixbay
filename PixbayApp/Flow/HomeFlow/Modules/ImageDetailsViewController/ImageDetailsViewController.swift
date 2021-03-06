//
//  ImageDetailsViewController.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class ImageDetailsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: ImageDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil, "viewModel must be set")

        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension ImageDetailsViewController {
    func configureViews() {
        title = viewModel.titleText
        tableView.register(cell: ImageDetailsTableViewCell.self)
        tableView.register(cell: ImageInteractionsTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        // This dispatch queue is added as a workaround for the issue on
        // https://github.com/RxSwiftCommunity/RxDataSources/issues/331
        // should be removed on next release of RXSwift
        DispatchQueue.main.async { [weak self] in
            self?.setupTableView()
        }
    }

    func setupTableView() {
        viewModel.sections.bind(to: tableView.rx.items) { [unowned self] tableView, index, type in
            let indexPath = IndexPath(row: index, section: 0)
            return self.makeTableViewCell(for: tableView, with: type, indexPath: indexPath)
        }.disposed(by: viewModel.disposeBag)
    }

    func makeTableViewCell(for: UITableView,
                           with type: ImageDetailsViewModel.CellType,
                           indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .imageDetails:
            let cell = tableView.dequeueReusableCell(cell: ImageDetailsTableViewCell.self, indexPath: indexPath)
            cell.configure(with: ImageDetailsCellViewModel(imageDetails: self.viewModel.imageDetails))
            return cell
        case .imageInteractions:
            let cell = tableView.dequeueReusableCell(cell: ImageInteractionsTableViewCell.self,
                                                     indexPath: indexPath)
            cell.configure(with: ImageInteractionsCellViewModel(imageDetails: self.viewModel.imageDetails))
            return cell
        }
    }
}
