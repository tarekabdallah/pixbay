//
//  HomeViewController.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet private weak var searchFieldContainer: UIView!
    @IBOutlet private weak var searchTextField: TextField!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        fetchImages()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private Helper Methods
private extension HomeViewController {
    func configureViews() {

        setupSearchButton()
        setupTableView()
    }

    func setupTableView() {
        tableView.register(cell: ImageTableViewCell.self)
        tableView.separatorStyle = .none
        viewModel.filteredImages.bind(to: tableView.rx.items(cell: ImageTableViewCell.self)) { _, item, cell in
            cell.configure(with: ImageCellViewModel(image: item))
        }.disposed(by: viewModel.disposeBag)
    }
    func setupSearchButton() {

    }

    func fetchImages() {
        viewModel.fetchImages(with: "hh").subscribe().disposed(by: viewModel.disposeBag)
    }
}
