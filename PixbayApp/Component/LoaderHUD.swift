//
//  LoaderHUD.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 8/1/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class LoaderHUD: UIView {
    static let `default` = LoaderHUD()

    private var mainHUDView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureView()
    }

    func startLoader() {
        UIApplication.shared.keyWindow?.addSubview(mainHUDView)
        mainHUDView.showLoader(loaderColor: .primary)
    }

    func stopLoader() {
        mainHUDView?.removeFromSuperview()
        mainHUDView?.hideLoader()
    }
}

// MARK: - Private helper methods
private extension LoaderHUD {
    func configureView() {
        mainHUDView = UIView(frame: UIScreen.main.bounds)
        let backgoundLayer = CALayer()
        backgoundLayer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
        backgoundLayer.frame = UIScreen.main.bounds
        mainHUDView.layer.addSublayer(backgoundLayer)
    }
}
