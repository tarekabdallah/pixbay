//
//  StoryboardLoadable.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {
    static var storyboardId: String { get }
    static var viewControllerId: String { get }
}

// swiftlint:disable force_cast
extension StoryboardLoadable where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: Self.self)
    }

    static var viewControllerId: String {
        return String(describing: Self.self)
    }

    static func loadFromStoryboard() -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: viewControllerId) as! Self
    }
}
