//
//  Loader.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Loader: UIView {
    private var activityIndicatorView: NVActivityIndicatorView!
    private var loaderColor: UIColor = .primary

    convenience init(frame: CGRect,
                     backgroundColor: UIColor?,
                     loaderColor: UIColor?,
                     type: NVActivityIndicatorType? = nil) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.loaderColor = loaderColor ?? .primary

        configureViews(type: type)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func startAnimating() {
        activityIndicatorView.startAnimating()
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}

// MARK: - Private Helper Methods
private extension Loader {
    func configureViews(type: NVActivityIndicatorType? = nil) {
        activityIndicatorView = NVActivityIndicatorView(frame: .zero,
                                                        type: type ?? .lineScale,
                                                        color: loaderColor,
                                                        padding: 2)
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let widthRatio = frame.width / UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: min(1.3 - widthRatio, 1)),
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        ])
    }
}
