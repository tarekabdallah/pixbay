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
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet private weak var searchFieldContainer: UIView!
    @IBOutlet private weak var searchTextField: TextField!
    @IBOutlet private weak var logoutButton: ImageButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noResultsView: UIView!
    @IBOutlet private weak var noResultsFoundLabel: UILabel!

    private let spinner = UIActivityIndicatorView(style: .gray)

    var viewModel: HomeViewModel!
    var onImageSelected: ((ImageModel) -> Void)?
    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil, "viewModel must be set")

        configureViews()
        fetchImages(resetPage: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private Helper Methods
private extension HomeViewController {
    func configureViews() {
        noResultsFoundLabel.applyStyle(textColor: .darkText,
                                       font: .medium,
                                       size: .title)

        searchTextField.placeholder = viewModel.searchPlaceholderText
        noResultsFoundLabel.text = viewModel.noResultsFoundText
        setupRxComponents()
        setupSpinner()
        setupPagination()

        // This dispatch queue is added as a workaround for the issue on
        // https://github.com/RxSwiftCommunity/RxDataSources/issues/331
        // should be removed on next release of RXSwift
        DispatchQueue.main.async { [weak self] in
            self?.setupTableView()
        }
    }

    func setupPagination() {
        tableView
            .rx
            .contentOffset
            .debounce(.milliseconds(50), scheduler: MainScheduler.instance)
            .map { [unowned self] _ in
                return self.tableView.isNearTheBottomEdge
                    && !self.viewModel.reachedLastPage
                    && self.viewModel.currentPage != 1
            }.subscribe(onNext: { [unowned self] shouldLoadNextPage in
                if shouldLoadNextPage {
                    self.fetchImages()
                }
            }, onError: nil).disposed(by: viewModel.disposeBag)
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
            cell.selectionStyle = .none
        }.disposed(by: viewModel.disposeBag)

        tableView.rx.modelSelected(ImageModel.self).subscribe(onNext: { [unowned self] imageDetails in
            self.onImageSelected?(imageDetails)
            }, onError: nil).disposed(by: viewModel.disposeBag)
    }

    func fetchImages(resetPage: Bool = false) {
        if resetPage {
            tableView.showLoader()
        } else {
            spinner.startAnimating()
        }
        viewModel.fetchImages(with: searchTextField.text,
                              resetPages: resetPage).subscribe { [weak self] _ in
                                guard let self = self else { return }

                                self.noResultsView.isHidden = !self.viewModel.fetchedImages.isEmpty
                                self.tableView.hideLoader()
                                self.spinner.stopAnimating()
        }.disposed(by: viewModel.disposeBag)
    }

    func setupSpinner() {
        spinner.color = .primary
        spinner.frame.size.height = 60
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        tableView.tableFooterView = spinner
    }
}
