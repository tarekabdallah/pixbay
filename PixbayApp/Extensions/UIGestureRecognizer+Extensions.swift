//
//  UIGestureRecognizer+Extensions.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    func isTouchInside(_ view: UIView?) -> Bool {
        return view?.bounds.contains(location(in: view)) ?? false
    }

    func isTouchInside(_ views: [UIView?]) -> Bool {
        let boolValues = views.map { isTouchInside($0) }
        return boolValues.first { $0 } ?? false
    }

    func indexPath(tableView: UITableView) -> IndexPath? {
        guard isTouchInside(tableView),
            let indexPath = tableView.indexPathForRow(at: location(in: tableView)) else {
                return nil
        }

        return indexPath
    }
}
