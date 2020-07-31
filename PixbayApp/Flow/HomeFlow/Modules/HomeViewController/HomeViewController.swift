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
    var onImageSelected: ((ImageModel) -> Void)?

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
        searchTextField.placeholder = viewModel.searchPlaceholderText
        searchTextField
            .rx
            .controlEvent([.editingChanged])
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [unowned self] in
                self.fetchImages(resetPage: true)
                }, onCompleted: nil, onDisposed: nil).disposed(by: viewModel.disposeBag)
        setupTableView()
    }

    func setupTableView() {
        tableView.register(cell: ImageTableViewCell.self)
        tableView.separatorStyle = .none
        viewModel.displayedImages.bind(to: tableView.rx.items(cell: ImageTableViewCell.self)) { _, item, cell in
            cell.configure(with: ImageCellViewModel(image: item))
        }.disposed(by: viewModel.disposeBag)

        tableView.rx.modelSelected(ImageModel.self).subscribe(onNext: { [unowned self] imageDetails in
            self.onImageSelected?(imageDetails)
        }, onError: nil).disposed(by: viewModel.disposeBag)
    }

    func fetchImages(resetPage: Bool = false) {
        viewModel.fetchImages(with: searchTextField.text,
                              resetPages: resetPage).subscribe().disposed(by: viewModel.disposeBag)
    }
}
