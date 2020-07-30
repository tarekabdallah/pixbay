//
//  TextField+Validate.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: TextField {
    func validate(_ validationType: ValidationType = .notEmpty) -> RxCocoa.ControlProperty<String> {
        let disposeBag = DisposeBag()
        let borderColor = UIColor(cgColor: base.layer.borderColor ?? UIColor.primary.cgColor)
        let borderWidth = base.layer.borderWidth
        controlEvent([.allEvents]).asObservable().subscribe { _ in
            self.text.orEmpty.subscribe { event in
                switch event {
                case let .next(text):
                    if !text.isValid(validationType) {
                        self.base.setBorder(borderColor: .destructive, borderWidth: borderWidth)
                        self.base.textColor = .destructive
                        self.base.hasError = true
                    } else {
                        self.base.setBorder(borderColor: borderColor, borderWidth: borderWidth)
                        self.base.textColor = .purple
                        self.base.hasError = false
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
        }.disposed(by: disposeBag)
        return text.orEmpty
    }
}
