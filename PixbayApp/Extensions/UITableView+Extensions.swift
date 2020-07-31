//
//  UITableView+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UITableView {
    func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
        (cell: Cell.Type)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable where Source.Element == Sequence {
            return items(cellIdentifier: cell.id, cellType: cell)
    }
}
// swiftlint:disable force_cast
extension UITableView {

    func register<Cell: UITableViewCell>(cell: Cell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.id)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(cell: Cell.Type, indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: cell.id, for: indexPath) as! Cell
    }

    func dequeueReusableCell<Cell: UITableViewCell>(cell: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: cell.id) as! Cell
    }
}

// MARK: - Private Computed Variables
private extension UITableViewCell {
    static var id: String {
        return String(describing: Self.self)
    }

    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}
