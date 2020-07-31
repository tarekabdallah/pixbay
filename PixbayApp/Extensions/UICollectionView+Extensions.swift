//
//  UICollectionView+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UICollectionView {
    func items<Sequence: Swift.Sequence, Cell: UICollectionViewCell, Source: ObservableType>
        (cell: Cell.Type)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable where Source.Element == Sequence {
            return items(cellIdentifier: cell.id, cellType: cell)
    }
}
// swiftlint:disable force_cast
extension UICollectionView {

    func register<Cell: UICollectionViewCell>(cell: Cell.Type) {
        register(cell.nib, forCellWithReuseIdentifier: cell.id)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(cell: Cell.Type, indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cell.id, for: indexPath) as! Cell
    }
}

// MARK: - Private Computed Variables
private extension UICollectionViewCell {
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
