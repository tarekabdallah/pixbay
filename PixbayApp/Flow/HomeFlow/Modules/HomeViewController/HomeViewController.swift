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
    @IBOutlet private weak var logoutButton: ImageButton!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: HomeViewModel!
    var onImageSelected: ((ImageModel) -> Void)?
    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil, "viewModel must be set")

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
        setupTableView()
        setupRxComponents()
    }

    func setupRxComponents() {
        searchTextField
            .rx
            .controlEvent([.editingChanged])
            .asDriver()
            .debounce(.milliseconds(500))
            .drive(onNext: { [unowned self] in
                self.fetchImages(resetPage: true)
                }, onCompleted: nil, onDisposed: nil).disposed(by: viewModel.disposeBag)

        logoutButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [unowned self] in
                self.viewModel.clearUser()
                self.onLogout?()
                }, onCompleted: nil, onDisposed: nil).disposed(by: viewModel.disposeBag)

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
